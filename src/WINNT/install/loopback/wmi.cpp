/*

Copyright 2004 by the Massachusetts Institute of Technology

All rights reserved.

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of the Massachusetts
Institute of Technology (M.I.T.) not be used in advertising or publicity
pertaining to distribution of the software without specific, written
prior permission.

M.I.T. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
M.I.T. BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.

*/

//**************************************************************************
//
// Description:
//
//      Call EnableStatic method of Win32_NetworkAdapterConfiguration
//      for some network adapter GUID.
//
// Note:
//
//	The EnableStatic method is notsupported on Win9x platforms.
//
//**************************************************************************

#define _WIN32_DCOM
#include <windows.h>
#include <comdef.h>
#include <wbemidl.h>
#include <tchar.h>

#include <devguid.h>

/* These two are from the Windows DDK */
#include <netcfgx.h>
#include <netcfgn.h>

#include <shlobj.h>
//#include <objbase.h>

//#ifndef TEST
//inline void printf(char*, ...) {}
//#else
#include <stdio.h>
//#endif

#include "loopbackutils.h"

#define CLEANUP_ON_FAILURE(hr) \
	do { if (!SUCCEEDED(hr)) {goto cleanup;} } while (0)

#define CLEANUP_ON_AND_SET(check, var, value) \
    do { if (check) { (var) = (value); goto cleanup; } } while (0)

#define ETCDIR "\\drivers\\etc"

#define EACCES (13)
#define ENOENT (2)

DWORD AdjustMaxLana(DWORD dwMaxLana);

typedef
HRESULT
(*FindNetworkAdapterConfigurationInstance_t)(
    IN  PVOID pContext,
    IN  IWbemServices *pSvc,
    OUT BSTR* pPath
    );

HRESULT
FindNetworkAdapterConfigurationInstanceByGUID(
    IN  PVOID pContext,
    IN  IWbemServices *pSvc,
    OUT BSTR* pPath
    )
{
    HRESULT hr = 0;
    BOOL bFound = FALSE;
    BSTR Language = 0;
    BSTR Query = 0;
    IEnumWbemClassObject* pEnum = 0;
    IWbemClassObject* pObj = 0;
    VARIANT Value;
    VariantInit(&Value);
    LPCWSTR adapter_guid = (LPCWSTR)pContext;

    // Check arguments
    if (!pPath || !adapter_guid || *pPath)
        return E_INVALIDARG;

    *pPath = 0;

    // Query for all network adapters
    Language = SysAllocString(L"WQL");
    Query = SysAllocString(L"select * from Win32_NetworkAdapterConfiguration");

    // Issue the query.
    hr = pSvc->ExecQuery(Language,
                         Query,
                         WBEM_FLAG_FORWARD_ONLY,         // Flags
                         0,                              // Context
                         &pEnum);
    if (!SUCCEEDED(hr))
    {
        ReportMessage(0,"ExecQuery() error",NULL,NULL, hr);
        goto cleanup;
    }

    // Retrieve the objects in the result set.
    while (!bFound)
    {
        ULONG uReturned = 0;

        hr = pEnum->Next(0,                  // Time out
                         1,                  // One object
                         &pObj,
                         &uReturned);
        CLEANUP_ON_FAILURE(hr);

        if (uReturned == 0)
            break;

        // Use the object.
        hr  = pObj->Get(L"SettingID", // property name
                        0L,
                        &Value,       // output to this variant
                        NULL,
                        NULL);
        CLEANUP_ON_FAILURE(hr);

        bFound = !wcscmp(adapter_guid, V_BSTR(&Value));
        
        if (bFound)
        {
            ReportMessage(1,"Found adapter", NULL,V_BSTR(&Value),0);
            VariantClear(&Value);
            hr = pObj->Get(L"__RELPATH", // property name
                           0L,
                           &Value,       // output to this variant
                           NULL,
                           NULL);
            CLEANUP_ON_FAILURE(hr);

            *pPath = SysAllocString(V_BSTR(&Value));
            
        }
        
        VariantClear(&Value);
        
        // Release it.
        // ===========
        pObj->Release();    // Release objects not owned.
        pObj = 0;
    }


    // All done.
 cleanup:
    SysFreeString(Query);
    SysFreeString(Language);
    VariantClear(&Value);
    if (pEnum)
        pEnum->Release();
    if (pObj)
        pObj->Release();

    return *pPath ? 0 : ( SUCCEEDED(hr) ? WBEM_E_NOT_FOUND : hr );
}

HRESULT
SetupStringAsSafeArray(LPCWSTR s, VARIANT* v)
{
    HRESULT hr = 0;
    BSTR b = 0;
    SAFEARRAY* array = 0;
    long index[] = {0};

    if (V_VT(v) != VT_EMPTY)
        return E_INVALIDARG;

    b = SysAllocString(s);
    CLEANUP_ON_AND_SET(!b, hr, E_OUTOFMEMORY);

    array = SafeArrayCreateVector(VT_BSTR, 0, 1);
    CLEANUP_ON_AND_SET(!array, hr, E_OUTOFMEMORY);

    hr = SafeArrayPutElement(array, index, b);
    CLEANUP_ON_FAILURE(hr);

    V_VT(v) = VT_ARRAY|VT_BSTR;
    V_ARRAY(v) = array;

 cleanup:
    if (b)
        SysFreeString(b);
    if (!SUCCEEDED(hr))
    {
        if (array)
            SafeArrayDestroy(array);
    }
    return hr;
}


HRESULT
WMIEnableStatic(
    FindNetworkAdapterConfigurationInstance_t pFindInstance,
    PVOID pContext,
    LPCWSTR ip,
    LPCWSTR mask
    )
{
    HRESULT hr = 0;

    IWbemLocator* pLocator = 0;
    IWbemServices* pNamespace = 0;
    IWbemClassObject* pClass = 0;
    IWbemClassObject* pOutInst = 0;
    IWbemClassObject* pInClass = 0;
    IWbemClassObject* pInInst = 0;

    BSTR NamespacePath = 0;
    BSTR ClassPath = 0;
    BSTR InstancePath = 0;
    BSTR MethodName = 0; // needs to be BSTR for ExecMethod()

    VARIANT v_ip_list;
    VariantInit(&v_ip_list);

    VARIANT v_mask_list;
    VariantInit(&v_mask_list);

    VARIANT v_ret_value;
    VariantInit(&v_ret_value);

    int count;

    // end of declarations & NULL initialization

    NamespacePath = SysAllocString(L"root\\cimv2");
    CLEANUP_ON_AND_SET(!NamespacePath, hr, E_OUTOFMEMORY);

    ClassPath = SysAllocString(L"Win32_NetWorkAdapterConfiguration");
    CLEANUP_ON_AND_SET(!ClassPath, hr, E_OUTOFMEMORY);

    MethodName = SysAllocString(L"EnableStatic");
    CLEANUP_ON_AND_SET(!MethodName, hr, E_OUTOFMEMORY);

    // Initialize COM and connect up to CIMOM

    hr = CoInitializeEx(0, COINIT_MULTITHREADED);
    CLEANUP_ON_FAILURE(hr);

    /* When called from an MSI this will generally fail.  This should only be called once
	   per process and not surprisingly MSI beats us to it.  So ignore return value and
	   hope for the best. */
    hr = CoInitializeSecurity(NULL, -1, NULL, NULL,
                              RPC_C_AUTHN_LEVEL_CONNECT,
                              RPC_C_IMP_LEVEL_IMPERSONATE,
                              NULL, EOAC_NONE, 0);
    /* CLEANUP_ON_FAILURE(hr); */

    hr = CoCreateInstance(CLSID_WbemLocator, 0, CLSCTX_INPROC_SERVER,
                          IID_IWbemLocator, (LPVOID *) &pLocator);
    CLEANUP_ON_FAILURE(hr);

    hr = pLocator->ConnectServer(NamespacePath, NULL, NULL, NULL, 0,
                                 NULL, NULL, &pNamespace);
    CLEANUP_ON_FAILURE(hr);

    ReportMessage(0,"Connected to WMI",NULL,NULL,0);

    // Set the proxy so that impersonation of the client occurs.
    hr = CoSetProxyBlanket(pNamespace,
                           RPC_C_AUTHN_WINNT,
                           RPC_C_AUTHZ_NONE,
                           NULL,
                           RPC_C_AUTHN_LEVEL_CALL,
                           RPC_C_IMP_LEVEL_IMPERSONATE,
                           NULL,
                           EOAC_NONE);
    CLEANUP_ON_FAILURE(hr);

    // Get the class object
    hr = pNamespace->GetObject(ClassPath, 0, NULL, &pClass, NULL);
    CLEANUP_ON_FAILURE(hr);

    // Get the instance
    hr = pFindInstance(pContext, pNamespace, &InstancePath);
    CLEANUP_ON_FAILURE(hr);

    ReportMessage(0,"Found Adapter Instance",NULL, InstancePath,0);

#if 0
    // Use the adapter instance index to set MAXLANA in the registry.
    {
        DWORD dwIndex;
        if (swscanf(InstancePath, L"Win32_NetworkAdapterConfiguration.Index=%u", &dwIndex)==1)
        {
            DWORD ret = 0; 
            ReportMessage(1,"Setting MAXLANA",NULL,NULL,dwIndex+1);
            ret = AdjustMaxLana(dwIndex+1);
            if (ret) ReportMessage(0,"AdjustMaxLana returned the error code ",NULL,NULL,ret);
        }
    }
#endif

    // Get the input argument and set the property
    hr = pClass->GetMethod(MethodName, 0, &pInClass, NULL);
    CLEANUP_ON_FAILURE(hr);

    hr = pInClass->SpawnInstance(0, &pInInst);
    CLEANUP_ON_FAILURE(hr);

    // Set up parameters
    hr = SetupStringAsSafeArray(ip, &v_ip_list);
    CLEANUP_ON_FAILURE(hr);

    hr = pInInst->Put(L"IPAddress", 0, &v_ip_list, 0);
    CLEANUP_ON_FAILURE(hr);

    hr = SetupStringAsSafeArray(mask, &v_mask_list);
    CLEANUP_ON_FAILURE(hr);

    hr = pInInst->Put(L"SubNetMask", 0, &v_mask_list, 0);
    CLEANUP_ON_FAILURE(hr);

    // Sleep for a twenty seconds
    ReportMessage(0,"Calling ExecMethod in 20 seconds...",NULL,NULL,0);
    Sleep(10000);
    ReportMessage(0,"Calling ExecMethod in 10 seconds...",NULL,NULL,0);
    Sleep(5000);  
    ReportMessage(0,"Calling ExecMethod in  5 seconds...",NULL,NULL,0);
    Sleep(2000);

//    printf("Skipping ExecMethod\n");
//    hr = 0;
//    goto cleanup;

    // Try up to five times, sleeping 3 seconds between tries
    for (count=0; count<5; count++)
    {
        if (count>0) ReportMessage(0,"Trying again in 3 seconds...",NULL,NULL,0);

	Sleep(3000);
  
        ReportMessage(0,"Calling ExecMethod NOW...          ",NULL,NULL,0);     

        // Call the method

        hr = pNamespace->ExecMethod(InstancePath, MethodName, 0, NULL, pInInst,
                                  &pOutInst, NULL);   

        if (!SUCCEEDED(hr))
        {
           ReportMessage(0,"ExecMethod failed",NULL,NULL, hr);
           continue;
        }

        // Get the EnableStatic method return value
        hr = pOutInst->Get(L"ReturnValue", 0, &v_ret_value, 0, 0);

        if (!SUCCEEDED(hr))
        {
          ReportMessage(0,"WARNING: Could not determine return value for EnableStatic ",NULL,NULL, hr);
          continue;
        }

        hr = V_I4(&v_ret_value);                


        if(hr != 0)
            ReportMessage(0,"EnableStatic failed ", NULL,NULL,hr);
        else
        {
            ReportMessage(0,"EnableStatic succeeded",NULL,NULL,0);
            break;
        }

    }



 cleanup:
    // Free up resources
    VariantClear(&v_ret_value);
    VariantClear(&v_ip_list);
    VariantClear(&v_mask_list);

    SysFreeString(NamespacePath);
    SysFreeString(ClassPath);
    SysFreeString(InstancePath);
    SysFreeString(MethodName);

    if (pClass) pClass->Release();
    if (pInInst) pInInst->Release();
    if (pInClass) pInClass->Release();
    if (pOutInst) pOutInst->Release();
    if (pLocator) pLocator->Release();
    if (pNamespace) pNamespace->Release();

    CoUninitialize();
    return hr;
}


/**********************************************************
* LoopbackBindings :  unbind all other 
*       protocols except TCP/IP, netbios, netbt. 
*/
extern "C" HRESULT LoopbackBindings (LPCWSTR loopback_guid)
{
    HRESULT			hr = 0;
    INetCfg			*pCfg = NULL;
    INetCfgLock		*pLock = NULL;
    INetCfgComponent *pAdapter = NULL;
    IEnumNetCfgComponent *pEnumComponent = NULL;
    BOOL			bLockGranted = FALSE;
    BOOL			bInitialized = FALSE;
    BOOL			bConfigChanged = FALSE;
    LPWSTR			swName = NULL;
    GUID            g;
    wchar_t         device_guid[100];
    DWORD			lenDeviceId;    
    
    ReportMessage(0,"Running LoopbackBindings()...",NULL,NULL,0);
    
    hr = CoInitializeEx( NULL, COINIT_DISABLE_OLE1DDE | COINIT_APARTMENTTHREADED ); 
    CLEANUP_ON_FAILURE(hr);
    
    hr = CoCreateInstance( CLSID_CNetCfg, NULL, CLSCTX_INPROC_SERVER, IID_INetCfg, (void**)&pCfg );
    CLEANUP_ON_FAILURE(hr);
    
    hr = pCfg->QueryInterface( IID_INetCfgLock, (void**)&pLock );
    CLEANUP_ON_FAILURE(hr);
    
    hr = pLock->AcquireWriteLock( 1000, L"AFS Configuration", NULL );
    CLEANUP_ON_FAILURE(hr);
    bLockGranted = TRUE;
    
    hr = pCfg->Initialize( NULL );
    CLEANUP_ON_FAILURE(hr);
    bInitialized = TRUE;
    
    hr = pCfg->EnumComponents( &GUID_DEVCLASS_NET, &pEnumComponent );
    CLEANUP_ON_FAILURE(hr);
    
    
    while( pEnumComponent->Next( 1, &pAdapter, NULL ) == S_OK )
    {
        pAdapter->GetDisplayName( &swName );
        pAdapter->GetInstanceGuid( &g );
        StringFromGUID2(g, device_guid, 99);
        
        if(!wcscmp( device_guid, loopback_guid )) // found loopback adapter
        {
            INetCfgComponentBindings *pBindings;
            INetCfgBindingPath *pPath;
            IEnumNetCfgBindingPath *pEnumPaths;
            INetCfgComponent *upper;
            
            ReportMessage(0,"LoopbackBindings found", NULL, device_guid,0 );
            
            hr = pAdapter->QueryInterface( IID_INetCfgComponentBindings, (void**) &pBindings);
            if(hr==S_OK)
            {
                hr = pBindings->EnumBindingPaths( EBP_ABOVE, &pEnumPaths );
                if(hr==S_OK)
                {
                    while(pEnumPaths->Next( 1, &pPath, NULL ) == S_OK)
                    {
                        pPath->GetOwner( &upper );
                        
                        LPWSTR swId = NULL, swName = NULL;
                        
                        upper->GetDisplayName( &swName );
                        upper->GetId( &swId );
                        
                        ReportMessage(1,"Looking at ",NULL, swName, 0);
                                                                        
                        {
                            ReportMessage(1,"  Moving to the end of binding order...",NULL,NULL,0);
                            INetCfgComponentBindings *pBindings2;
                            hr = upper->QueryInterface( IID_INetCfgComponentBindings, (void**) &pBindings2);
                            if (hr==S_OK)
                            {
                                ReportMessage(1,"...",0,0,0);
                                hr = pBindings2->MoveAfter(pPath, NULL);                                
                                pBindings2->Release();                               
                                bConfigChanged=TRUE;
                            }
                            if (hr==S_OK) ReportMessage(1,"success",0,0,0); else ReportMessage(0,"Binding change failed",0,0,hr);                                                        
                                                                                                            
                        }                        
                        
                        if ( !_wcsicmp(swId, L"ms_netbios")  || 
                            !_wcsicmp(swId, L"ms_tcpip")    ||
                            !_wcsicmp(swId, L"ms_netbt")      )
                        {
                            if (pPath->IsEnabled()!=S_OK)
                            {
                                ReportMessage(1,"  Enabling ",0,swName,0);
                                hr = pPath->Enable(TRUE);
                                if (hr==S_OK) ReportMessage(1,"success",0,0,0); else ReportMessage(0,"Proto failed",0,0,hr);
                                bConfigChanged=TRUE;
                            }
                            
                            
                        }
                        else //if (!_wcsicmp(swId, L"ms_server") || (!_wcsicmp(swId, L"ms_msclient")) 
                        {
                            if (pPath->IsEnabled()==S_OK)
                            {
                                ReportMessage(1,"  Disabling ",0,swName,0);
                                hr = pPath->Enable(FALSE);
                                if (hr==S_OK) ReportMessage(1,"success",0,0,0); else ReportMessage(0,"Proto failed",0,0,hr);
                                bConfigChanged=TRUE;
                            }
                        }
                        
                        CoTaskMemFree( swName );
                        CoTaskMemFree( swId );
                        
                        pPath->Release();
                    }
                    pEnumPaths->Release();
                }
                pBindings->Release();
            } // hr==S_OK for QueryInterface IID_INetCfgComponentBindings
        }
        
        CoTaskMemFree( swName );
        
        pAdapter->Release();
    }
    
    pEnumComponent->Release();    
    
    hr = 0;
    
cleanup:
    
    if(bConfigChanged) pCfg->Apply();
    
    if(pAdapter) pAdapter->Release();
    
    if(bInitialized) pCfg->Uninitialize();
    if(bLockGranted) pLock->ReleaseWriteLock();
    
    if(pLock) pLock->Release();
    if(pCfg) pCfg->Release();
    
    if (hr) ReportMessage(0,"LoopbackBindings() is returning ",0,0,hr);
    return hr;
}

        
        extern "C"
            DWORD
SetIpAddress(
    LPCWSTR guid,
    LPCWSTR ip,
    LPCWSTR mask
    )
{
    ReportMessage(0,"Running SetIpAddress()...",0,0,0);
    HRESULT hr = 0;

    hr = WMIEnableStatic(FindNetworkAdapterConfigurationInstanceByGUID,
                        (PVOID)guid, ip, mask);
    return hr;
}

/* Set MAXLANA in the registry to the specified value, unless the existing registry value is larger */
DWORD AdjustMaxLana(DWORD dwMaxLana)
{

    LONG ret = 0;
    HKEY hNetBiosParamKey = NULL;
    DWORD dwType, dwExistingMaxLana, dwSize;

    ReportMessage(0,"Making sure MaxLana is large enough",0,0, dwMaxLana);

    ret = RegOpenKeyEx(HKEY_LOCAL_MACHINE, _T("SYSTEM\\CurrentControlSet\\Services\\NetBIOS\\Parameters"), 
        0, KEY_ALL_ACCESS , &hNetBiosParamKey);
    if (ret) return ret;


    
    dwSize = 4;
    ret = RegQueryValueEx(hNetBiosParamKey, _T("MaxLana"), 0, &dwType, (LPBYTE) &dwExistingMaxLana, &dwSize);
    if ((ret) && (ret != ERROR_MORE_DATA) && (ret != ERROR_FILE_NOT_FOUND)) 
    {
        RegCloseKey(hNetBiosParamKey);
        return ret;
    }

    if ((dwType != REG_DWORD) || (ret)) dwExistingMaxLana = 0;

    ReportMessage (1,"MaxLana is currently",0,0, dwExistingMaxLana);

    if (dwExistingMaxLana < dwMaxLana) 
    {
        ReportMessage (1,"Changing MaxLana", 0,0,dwMaxLana);
        ret = RegSetValueEx(hNetBiosParamKey, _T("MaxLana"), 0, REG_DWORD, (const BYTE*)&dwMaxLana, 4);
        if (ret) 
        {
            RegCloseKey(hNetBiosParamKey);
            return ret;
        }       

    }

    RegCloseKey(hNetBiosParamKey);
    return 0;


}

extern "C" 
BOOL UpdateHostsFile( LPCWSTR swName, LPCWSTR swIp, LPCSTR szFilename, BOOL bPre )
{
    char szIp[2048], szName[2048];
    char etcPath[MAX_PATH];
	char tempPath[MAX_PATH];
	char buffer[2048], temp[2048];
	char *str;
	HRESULT rv;
	DWORD fa,len;
	FILE *hFile, *hTemp;
	
    _snprintf(szIp, 2047, "%S", swIp);
    _snprintf(szName, 2047, "%S", swName);
    strupr(szName);
    ReportMessage(0,"Starting UpdateHostsFile() on file",szFilename,0,0);

	rv = SHGetFolderPathA( NULL, CSIDL_SYSTEM, NULL, SHGFP_TYPE_CURRENT , etcPath );
	if(rv != S_OK) return FALSE;

	strcat( etcPath, ETCDIR );

	fa = GetFileAttributesA( etcPath );

	if(fa == INVALID_FILE_ATTRIBUTES)
	{
		// the directory doesn't exist
		// it should be there. non-existence implies more things are wrong
		ReportMessage(0, "Path does not exist ", etcPath,0,0 );
		return FALSE;
	}

	strcpy( tempPath, etcPath );
	strcat( etcPath, "\\" );
	strcat( etcPath, szFilename );

	fa = GetFileAttributesA( etcPath );

	if(fa == INVALID_FILE_ATTRIBUTES)
	{
		ReportMessage(0, "File not found. Creating...", szFilename,0,0);

		hFile = fopen( etcPath, "w" );
		if(!hFile)
		{
			ReportMessage(0,"FAILED : can't create file",etcPath,0,errno);
			return FALSE;
		}

		fprintf(hFile, "%s\t%s%s\n", szIp, szName, (bPre)?"\t#PRE":"");

		fclose( hFile );

		ReportMessage(1,"done",0,0,0);
	}
	else // the file exists. parse and update
	{

		ReportMessage(1, "Updating file ...",szFilename,0,0 );

		hFile = fopen( etcPath, "r");
		if(!hFile)
		{
			ReportMessage(0,"FAILED : can't open file",etcPath,0,errno);
			return FALSE;
		}

		strcat( tempPath, szFilename );
		strcat( tempPath, ".tmp" );
		hTemp = fopen( tempPath, "w");
		if(!hTemp)
		{
			ReportMessage(0,"FAILED : can't create temp file",tempPath,0,errno);
			fclose(hFile);
			return FALSE;
		}

		while(fgets( buffer, 2046, hFile))
		{
			strcpy( temp, buffer );
			strupr( temp );

            if ((strlen(temp)<1) || (*(temp+strlen(temp)-1)!='\n')) strcat(temp, "\n");

			if(!(str = strstr(temp, szName)))
			{
				fputs( buffer, hTemp );
			}
			else
			{
				// check for FOOBAFS or AFSY
				//if(str <= temp || (*(str-1) != '-' && !isspace(*(str+strlen(szName)))))
				if ( (str == temp) || (!*(str+strlen(szName))) || (!isspace(*(str-1))) || (!isspace(*(str+strlen(szName)))) )
                    fputs( buffer, hTemp );
			}
		}


		len = 2048;
		GetComputerNameA( buffer, &len );
		buffer[11] = 0;
		fprintf( hTemp, "%s\t%s%s\n", szIp, szName, (bPre)?"\t#PRE":"");

		fclose( hTemp );
		fclose( hFile );

		strcpy(buffer, etcPath);
		strcat(buffer, ".old");

        if(!DeleteFileA(buffer)) {
            DWORD status;
            int i;
            char * eos;

            status = GetLastError();
            if(status == ERROR_ACCESS_DENIED) {
                /* try changing the file attribtues. */
                if(SetFileAttributesA(buffer, FILE_ATTRIBUTE_NORMAL) &&
                    DeleteFileA(buffer)) {
                    status = 0;
                    ReportMessage(0,"Changed attributes and deleted back host file", buffer, 0, 0);
                }
            }
            if(status && status != ERROR_FILE_NOT_FOUND) {
                /* we can't delete the file.  Try to come up with 
                   a different name that's not already taken. */
                srand(GetTickCount());
                eos = buffer + strlen(buffer);
                for(i=0; i < 50; i++) {
                    itoa(rand(), eos, 16);
                    if(GetFileAttributesA(buffer) == INVALID_FILE_ATTRIBUTES &&
                        GetLastError() == ERROR_FILE_NOT_FOUND)
                        break;
                }
                /* At this point if we don't have a unique name, we just let the rename
                   fail.  Too bad. */
            }
        }

        if(!MoveFileA( etcPath, buffer )) {
            ReportMessage(0,"FAILED: Can't rename old file", etcPath, 0, GetLastError());
            return FALSE;
        }

		if(!MoveFileA( tempPath, etcPath ) != 0)
		{
			ReportMessage(0,"FAILED : Can't rename new file", tempPath, 0, GetLastError());
			return FALSE;
		}

	}

	return TRUE;
}

#ifdef TEST
#if 0
int
wmain(
    int argc,
    wchar_t* argv[]
    )
{
    if (argc < 3)
    {
        printf("usage: %S ip mask\n"
               "  example: %S 10.0.0.1 255.0.0.0", argv[0], argv[0]);
        return 0;
    }

    return WMIEnableStatic(FindNetworkAdapterConfigurationInstanceByGUID,
                           L"{B4981E32-551C-4164-96B6-B8874BD2E555}",
                           argv[1], argv[2]);
}
#else
int
wmain(
    int argc,
    wchar_t* argv[]
    )
{
    if (argc < 4)
    {
        printf("usage: %S adapter_guid ip mask\n"
               "  example: %S {B4981E32-551C-4164-96B6-B8874BD2E555} "
               "10.0.0.1 255.0.0.0", argv[0], argv[0]);
        return 0;
    }

    return WMIEnableStatic(FindNetworkAdapterConfigurationInstanceByGUID,
                           argv[1], argv[2], argv[3]);
}
#endif
#endif

