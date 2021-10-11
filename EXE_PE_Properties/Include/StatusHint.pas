(******************************************************************************
 ******************************************************************************
 ***                                                                        ***
 ***             Copyright (c) 1995 - 2002 by -=Assarbad [GoP]=-            ***
 ***      ____________                 ___________                          ***
 ***     /\   ________\               /\   _____  \     UIN: 281645         ***
 ***    /  \  \       /    __________/  \  \    \  \    AIM: nixlosheute    ***
 ***    \   \  \   __/___ /\   _____  \  \  \____\  \        nixahnungnicht ***
 ***     \   \  \ /\___  \  \  \    \  \  \   _______\                      ***
 ***      \   \  \ /   \  \  \  \    \  \  \  \      /  Assarbad@gmx.info   ***
 ***       \   \  \_____\  \  \  \____\  \  \  \____/                       ***
 ***        \   \___________\  \__________\  \__\                           ***
 ***         \  /           /  /          /  /  /                           ***
 ***          \/___________/ \/__________/ \/__/                            ***
 ***                                                                        ***
 ***              May the source be with you, stranger ... ;)               ***
 ***    Snizhok, eto ne tolko fruktovij kefir, snizhok, eto stil zhizn.     ***
 ***                                                                        ***
 *** Greets from -=Assarbad=- fly to YOU =)                                 ***
 *** Special greets fly 2 Nico, Casper, SA, Pizza, Navarion, Eugen, Zhenja, ***
 *** Xandros etc pp.                                                        ***
 ***                                                                        ***
 ***               [for questions/proposals drop me a mail]                 ***
 *********************************************************** ASCII by Assa ****
 ******************************************************************************)

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                                 _\\|//_
                                (` * * ')
 ______________________________ooO_(_)_Ooo_____________________________________
 LEGAL STUFF:
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 Copyright (c) 1995-2002, -=Assarbad=- ["copyright holder(s)"]
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
 3. The name(s) of the copyright holder(s) may not be used to endorse or
    promote products derived from this software without specific prior written
    permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
                             .oooO     Oooo.
 ____________________________(   )_____(   )___________________________________
                              \ (       ) /
                               \_)     (_/
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

var
  Mouse_HookID: HHOOK;
  lastID: word;

function MouseProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  statstr: string;
begin
  case nCode < 0 of
    true:
      Result := CallNextHookEx(Mouse_HookID, nCode, wParam, lParam);
  else
    begin
      if lastID <> GetDlgCtrlId(PMOUSEHOOKSTRUCT(lParam)^.HWND) then
        begin
          case GetDlgCtrlId(PMOUSEHOOKSTRUCT(lParam)^.HWND) of
            IDC_RADIO_PE32:
              begin
                statstr := 'This is a PE32 file.';
              end;
            IDC_RADIO_PE32_PLUS:
              begin
                statstr := 'This is a PE32+ file.';
              end;
            IDC_RADIO_NONPE:
              begin
                statstr := 'This is probably a DOS-only EXE.';
              end;
            IDC_RADIO_NONEXE:
              begin
                statstr := 'This is no EXE file.';
              end;
            IDC_RADIO_PE_UNKNOWN:
              begin
                statstr := 'This is probably (?) a PE file of some unknown format.';
              end;
            IDC_EDIT_MACTYPE:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.Machine) + ' = ' + XXX2str(NTImgHeaders.FileHeader.Machine) + ' [Machine type].';
              end;
            IDC_EDIT_MACTYPE_CT:
              begin
                statstr := Mach2Str(NTImgHeaders.FileHeader.Machine) + ' [Textual interpretation of machine type value].';
              end;
            IDC_BUTTON_SETCHECKSUM:
              begin
                statstr := 'This button allows you to set the checksum on the chosen PE file.';
              end;
            IDC_EDIT_PTSYMTAB:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.PointerToSymbolTable) + ' = ' + XXX2str(NTImgHeaders.FileHeader.PointerToSymbolTable) + ' [Pointer to the symbol table of the PE].';
              end;
            IDC_STATIC_MAGICWORD:
              begin
                statstr := word2hex(NTImgHeaders.OptionalHeader.Magic) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Magic) + ' [Magic word of the optional header].';
              end;
            IDC_STATIC_LINKERVERSION:
              begin
                statstr := 'Shows the version value the linker has set at link-time.';
              end;
            IDC_STATIC_SIZEOFCODE:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfCode) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfCode) + ' [Size of the code in PE].';
              end;
            IDC_STATIC_SIZEOFINITEDDATA:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfInitializedData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfInitializedData) + ' [Size of initialised data in PE].';
              end;
            IDC_EDIT_NUMSEC:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.NumberOfSections) + ' = ' + XXX2str(NTImgHeaders.FileHeader.NumberOfSections) + ' [Number of sections in PE].';
              end;
            IDC_EDIT_TIMESTAMP:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.TimeDateStamp) + ' = ' + XXX2str(NTImgHeaders.FileHeader.TimeDateStamp) + ' [Timestamp of PE in file header].';
              end;
            IDC_EDIT_NUMSYM:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.NumberOfSymbols) + ' = ' + XXX2str(NTImgHeaders.FileHeader.NumberOfSymbols) + ' [Number of symbols].';
              end;
            IDC_EDIT_CHARACT:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.Characteristics) + ' = ' + XXX2str(NTImgHeaders.FileHeader.Characteristics) + ' [Characteristics of PE - e.g.: DLL or not?!].';
              end;
            IDC_COMBO_CHARACT:
              begin
                statstr := 'Shows the decoded bitmask of the "Characteristics".';
              end;
            IDC_STATIC_SIZEOFUNINITEDDATA:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfUninitializedData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfUninitializedData) + ' [Size of uninitialised data in PE].';
              end;
            IDC_STATIC_BASEOFCODE:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.BaseOfCode) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.BaseOfCode) + ' [Base of code in PE].';
              end;
            IDC_STATIC_BASEOFDATA:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.BaseOfData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.BaseOfData) + ' [Base of data in PE].';
              end;
            IDC_EDIT_SIZEOFOH:
              begin
                statstr := dword2hex(NTImgHeaders.FileHeader.SizeOfOptionalHeader) + ' = ' + XXX2str(NTImgHeaders.FileHeader.SizeOfOptionalHeader) + ' [Size of the optional (for images mandatory) header].';
              end;
            IDC_STATIC_IMAGEBASE:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.ImageBase) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.ImageBase) + ' [Image base of PE, default 400000h].';
              end;
            IDC_STATIC_SECTALIGN_HEX,
              IDC_STATIC_SECTALIGN_DEC:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SectionAlignment) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SectionAlignment) + ' [Section alignment in PE].';
              end;
            IDC_STATIC_FILEALIGN_HEX,
              IDC_STATIC_FILEALIGN_DEC:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.FileAlignment) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.FileAlignment) + ' [File alignment of PE, default 512].';
              end;
            IDC_STATIC_OSVERSION:
              begin
                statstr := WordVersion2str(NTImgHeaders.OptionalHeader.MajorOperatingSystemVersion, NTImgHeaders.OptionalHeader.MinorOperatingSystemVersion) + ' [Desired OS Version of PE].';
              end;
            IDC_STATIC_CALCCHECKSUM_,
              IDC_STATIC_CALCCHECKSUM:
              begin
                statstr := dword2hex(GlobCorrectChecksum) + ' = ' + XXX2str(GlobCorrectChecksum) + ' [Calculated checksum for PE].';
              end;
            IDC_STATIC_ADDRESSOFENTRY:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.AddressOfEntryPoint) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.AddressOfEntryPoint) + ' [Entry point address].';
              end;
            IDC_STATIC_LOADERFLAGS,
              IDC_COMBO_LOADERFLAGS:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.LoaderFlags) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.LoaderFlags) + ' [Loader flags, bitmask not documented].';
              end;
            IDC_STATIC_DLLCHARACT,
              IDC_COMBO_DLLCHARACT:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.DllCharacteristics) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.DllCharacteristics) + ' [Characteristics if image is DLL].';
              end;
            IDC_BUTTON_SAVEREPORT:
              begin
                statstr := 'Saves the results into a text-file.';
              end;
            IDC_BUTTON_OPENFILE:
              begin
                statstr := 'Opens another file (hopefully a PE ;)';
              end;
            IDC_STATIC_FILENAME:
              begin
                statstr := 'Filename: ' + globfilename;
              end;
            IDC_STATIC_SIZEOFHEAP_RESERVED,
              IDC_STATIC_SIZEOFHEAP_COMMIT:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeapCommit) + '/' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeapReserve) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeapCommit) + '/' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeapReserve) + ' [Pre-defined heap sizes].';
              end;
            IDC_STATIC_SIZEOFSTACK_RESERVED,
              IDC_STATIC_SIZEOFSTACK_COMMIT:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfStackCommit) + '/' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfStackReserve) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfStackCommit) + '/' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfStackReserve) + ' [Pre-defined stack sizes].';
              end;
            IDC_STATIC_SUBSYSTEM,
              IDC_EDIT_SUBSYSTEM:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.Subsystem) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Subsystem) + ' = ' + subsys2str(NTImgHeaders.OptionalHeader.Subsystem) + ' [Subsystem of PE, 0 is for NT drivers].';
              end;
            IDC_STATIC_CHECKSUM:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.CheckSum) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.CheckSum) + ' [Currently set checksum of PE].';
              end;
            IDC_STATIC_SIZEOFHEADERS:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeaders) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeaders) + ' [Size of all headers].';
              end;
            IDC_STATIC_SIZEOFIMAGE:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.SizeOfImage) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfImage) + ' [Size of image as a hint for the loader].';
              end;
            IDC_STATIC_RESERVED:
              begin
                statstr := dword2hex(NTImgHeaders.OptionalHeader.Win32VersionValue) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Win32VersionValue) + ' [Sometimes called Win32VersionValue].';
              end;
            IDC_STATIC_SUBSYSVERSION:
              begin
                statstr := WordVersion2str(NTImgHeaders.OptionalHeader.MajorSubsystemVersion, NTImgHeaders.OptionalHeader.MinorSubsystemVersion) + ' [Desired subsystem version of PE].';
              end;
            IDC_STATIC_IMAGEVERSION:
              begin
                statstr := WordVersion2str(NTImgHeaders.OptionalHeader.MajorImageVersion, NTImgHeaders.OptionalHeader.MinorImageVersion) + ' [Version of Image, set by linker].';
              end;
            IDC_BUTTON_STATUS:
              begin
                statstr := 'About this program.';
              end;
          else
            statstr := progname;
          end;
          SetDlgItemText(maindlg, IDC_BUTTON_STATUS, @statstr[1]);
        end;
      lastID := GetDlgCtrlId(PMOUSEHOOKSTRUCT(lParam)^.HWND);
      Result := CallNextHookEx(Mouse_HookID, nCode, wParam, lParam);
    end;
  end;
end;

procedure InitHints;
begin
  Mouse_HookID := SetWindowsHookEx(WH_MOUSE, MouseProc, 0, GetCurrentThreadId());
end;

procedure DeinitHints;
begin
  if Mouse_HookID <> 0 then
    UnHookWindowsHookEx(Mouse_HookID);
end;

