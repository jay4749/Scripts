<<<<<<< HEAD
﻿function SetRegPerm ($sRegKey)
{
#We need a Win32 class to take ownership of the Registry key
$definition = @"
using System;
using System.Runtime.InteropServices; 
 
namespace Win32Api
{
 
public class NtDll
{
[DllImport("ntdll.dll", EntryPoint="RtlAdjustPrivilege")]
public static extern int RtlAdjustPrivilege(ulong Privilege, bool Enable, bool CurrentThread, ref bool Enabled);
}
}
"@

Add-Type -TypeDefinition $definition -PassThru | Out-Null
[Win32Api.NtDll]::RtlAdjustPrivilege(9, $true, $false, [ref]$false) | Out-Null
 
#Setting ownership to Administrators
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($sRegKey,[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::takeownership)
$acl = $key.GetAccessControl()
$acl.SetOwner([System.Security.Principal.NTAccount]"Administrators")
$key.SetAccessControl($acl)
 
#Giving Administrators full control to the key
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ([System.Security.Principal.NTAccount]"Administrators","FullControl","Allow")
$acl.SetAccessRule($rule)
$key.SetAccessControl($acl)
}

Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\*\FxProperties' | `
? { $_.Property -contains '{E0A941A0-88A2-4df5-8D6B-DD20BB06E8FB},4' } | `
% {
SetRegPerm($_.Name.Replace('HKEY_LOCAL_MACHINE\',''))
New-ItemProperty -Path $_.PSPath -Name '{E0A941A0-88A2-4df5-8D6B-DD20BB06E8FB},4' -Value '2' -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},5' -Value '1023' -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},6' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x31,0x00,0x01,0x00,0x00,0x00,0x20,0x03,0x00,0x00,0x16,0x03,0x00,0x00,0xb8,0x01,0x00,0x00,0x48,0xfe,0xff,0xff,0xfc,0xfe,0xff,0xff,0x96,0x00,0x00,0x00,0xa8,0x02,0x00,0x00,0x16,0x03,0x00,0x00,0x8e,0x03,0x00,0x00,0xca,0x03,0x00,0x00)) -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},2' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x9e,0x21,0x01,0x00,0x00,0x00,0xf0,0xd8,0xff,0xff,0x8f,0xe8,0xff,0xff,0x00,0x00,0x00,0x00,0x7b,0x14,0x2e,0x3e,0xcd,0xcc,0xcc,0x3d,0x4c,0xfb,0xff,0xff,0x6f,0x12,0x83,0x3a,0xcf,0x00,0x00,0x00,0x6f,0x12,0x03,0x3b,0x00,0x00,0xc8,0x42,0x00,0x00,0xc8,0x42,0x00,0x40,0x9c,0x45)) -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name 'test' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x9e,0x21,0x01,0x00,0x00,0x00,0xf0,0xd8,0xff,0xff,0x8f,0xe8,0xff,0xff,0x00,0x00,0x00,0x00,0x7b,0x14,0x2e,0x3e,0xcd,0xcc,0xcc,0x3d,0x4c,0xfb,0xff,0xff,0x6f,0x12,0x83,0x3a,0xcf,0x00,0x00,0x00,0x6f,0x12,0x03,0x3b,0x00,0x00,0xc8,0x42,0x00,0x00,0xc8,0x42,0x00,0x40,0x9c,0x45)) -Force | Out-Null
=======
﻿function SetRegPerm ($sRegKey)
{
#We need a Win32 class to take ownership of the Registry key
$definition = @"
using System;
using System.Runtime.InteropServices; 
 
namespace Win32Api
{
 
public class NtDll
{
[DllImport("ntdll.dll", EntryPoint="RtlAdjustPrivilege")]
public static extern int RtlAdjustPrivilege(ulong Privilege, bool Enable, bool CurrentThread, ref bool Enabled);
}
}
"@

Add-Type -TypeDefinition $definition -PassThru | Out-Null
[Win32Api.NtDll]::RtlAdjustPrivilege(9, $true, $false, [ref]$false) | Out-Null
 
#Setting ownership to Administrators
$key = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey($sRegKey,[Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree,[System.Security.AccessControl.RegistryRights]::takeownership)
$acl = $key.GetAccessControl()
$acl.SetOwner([System.Security.Principal.NTAccount]"Administrators")
$key.SetAccessControl($acl)
 
#Giving Administrators full control to the key
$rule = New-Object System.Security.AccessControl.RegistryAccessRule ([System.Security.Principal.NTAccount]"Administrators","FullControl","Allow")
$acl.SetAccessRule($rule)
$key.SetAccessControl($acl)
}

Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\*\FxProperties' | `
? { $_.Property -contains '{E0A941A0-88A2-4df5-8D6B-DD20BB06E8FB},4' } | `
% {
SetRegPerm($_.Name.Replace('HKEY_LOCAL_MACHINE\',''))
New-ItemProperty -Path $_.PSPath -Name '{E0A941A0-88A2-4df5-8D6B-DD20BB06E8FB},4' -Value '2' -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},5' -Value '1023' -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},6' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x31,0x00,0x01,0x00,0x00,0x00,0x20,0x03,0x00,0x00,0x16,0x03,0x00,0x00,0xb8,0x01,0x00,0x00,0x48,0xfe,0xff,0xff,0xfc,0xfe,0xff,0xff,0x96,0x00,0x00,0x00,0xa8,0x02,0x00,0x00,0x16,0x03,0x00,0x00,0x8e,0x03,0x00,0x00,0xca,0x03,0x00,0x00)) -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name '{4b361010-def7-43a1-a5dc-071d955b62f7},2' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x9e,0x21,0x01,0x00,0x00,0x00,0xf0,0xd8,0xff,0xff,0x8f,0xe8,0xff,0xff,0x00,0x00,0x00,0x00,0x7b,0x14,0x2e,0x3e,0xcd,0xcc,0xcc,0x3d,0x4c,0xfb,0xff,0xff,0x6f,0x12,0x83,0x3a,0xcf,0x00,0x00,0x00,0x6f,0x12,0x03,0x3b,0x00,0x00,0xc8,0x42,0x00,0x00,0xc8,0x42,0x00,0x40,0x9c,0x45)) -Force | Out-Null
New-ItemProperty -Path $_.PSPath -Name 'test' -PropertyType Binary `
-Value ([byte[]](0x41,0x00,0x9e,0x21,0x01,0x00,0x00,0x00,0xf0,0xd8,0xff,0xff,0x8f,0xe8,0xff,0xff,0x00,0x00,0x00,0x00,0x7b,0x14,0x2e,0x3e,0xcd,0xcc,0xcc,0x3d,0x4c,0xfb,0xff,0xff,0x6f,0x12,0x83,0x3a,0xcf,0x00,0x00,0x00,0x6f,0x12,0x03,0x3b,0x00,0x00,0xc8,0x42,0x00,0x00,0xc8,0x42,0x00,0x40,0x9c,0x45)) -Force | Out-Null
>>>>>>> 178b7166ef0ab9619c0ebb66c4a4dd11b17caf13
}