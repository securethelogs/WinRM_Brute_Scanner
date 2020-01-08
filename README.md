# WinRM_Brute_Scanner
![Ctrlaltdel.blog](https://ctrla1tdel.files.wordpress.com/2019/04/cropped-thumb-1920-865098.jpg)

**Guide**: https://securethelogs.com.blog/?p=808

WinRM_Brute_Scanner.ps1 allows you to scan and brute force the WinRM service remotely.


I wrote this script to be able to scan for this service on a Windows system. Because this uses PowerShell commands, no AV should interfere, and no additional modules are required.  Once obtained, remote commands can be sent.

Download: https://github.com/securethelogs/WinRM_Brute_Scanner

WinRM Ports:

- Port: 5985 (http)
- Port: 5986 (https)


To find out more about the service: https://docs.microsoft.com/en-us/windows/win32/winrm/installation-and-configuration-for-windows-remote-management


**Importing Module**

First you must download and import the module:

Import-Module [Script location]



**Functions**:

- winrm_scanner
- winrm_brute


#This script was created by myself but I am not responsible for what it is used for. Please only use this on systems that you have approval for. 
