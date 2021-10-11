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

(*
  Version history

  v1.02 [03.10.2002]
  - corrected the file filter for PE files
  - adapted the format() function
  - corrected error which does not reset entries in the comboboxes if a new file
    is loaded

  v1.01 [26.03.2002]
  - basic funtionality exists.
  - first release

*)
program isexe;

uses
  Windows,
  commdlg,
  Messages;

{APPTYPE CONSOLE}
{$R main.res}

const
  IDD_DIALOG1 = 101;
  IDC_RADIO_PE32 = 1001;
  IDC_RADIO_PE32_PLUS = 1002;
  IDC_RADIO_NONPE = 1003;
  IDC_RADIO_NONEXE = 1004;
  IDC_RADIO_PE_UNKNOWN = 1005;
  IDC_EDIT_MACTYPE = 1007;
  IDC_EDIT_MACTYPE_CT = 1008;
  IDC_BUTTON_SETCHECKSUM = 1010;
  IDC_EDIT_PTSYMTAB = 1011;
  IDC_STATIC_MAGICWORD = 1012;
  IDC_STATIC_LINKERVERSION = 1013;
  IDC_STATIC_SIZEOFCODE = 1014;
  IDC_STATIC_SIZEOFINITEDDATA = 1015;
  IDC_EDIT_NUMSEC = 1016;
  IDC_EDIT_TIMESTAMP = 1017;
  IDC_EDIT_NUMSYM = 1018;
  IDC_EDIT_CHARACT = 1019;
  IDC_COMBO_CHARACT = 1020;
  IDC_STATIC_SIZEOFUNINITEDDATA = 1021;
  IDC_STATIC_BASEOFCODE = 1022;
  IDC_STATIC_BASEOFDATA = 1023;
  IDC_EDIT_SIZEOFOH = 1024;
  IDC_STATIC_IMAGEBASE = 1025;
  IDC_STATIC_SECTALIGN_HEX = 1026;
  IDC_STATIC_SECTALIGN_DEC = 1027;
  IDC_STATIC_FILEALIGN_HEX = 1028;
  IDC_STATIC_FILEALIGN_DEC = 1029;
  IDC_STATIC_OSVERSION = 1030;
  IDC_STATIC_CALCCHECKSUM = 1031;
  IDC_BUTTON_STATUS = 1032;
  IDC_STATIC_ADDRESSOFENTRY = 1033;
  IDC_COMBO_LOADERFLAGS = 1034;
  IDC_COMBO_DLLCHARACT = 1035;
  IDC_EDIT_SUBSYSTEM = 1036;
  IDC_BUTTON_SAVEREPORT = 1037;
  IDC_BUTTON_OPENFILE = 1038;
  IDC_STATIC_FILENAME = 1039;
  IDC_STATIC_CALCCHECKSUM_ = 1040;
  IDC_STATIC_LOADERFLAGS = 1047;
  IDC_STATIC_SIZEOFHEAP_COMMIT = 1048;
  IDC_STATIC_SIZEOFSTACK_RESERVED = 1049;
  IDC_STATIC_DLLCHARACT = 1050;
  IDC_STATIC_SUBSYSTEM = 1051;
  IDC_STATIC_CHECKSUM = 1052;
  IDC_STATIC_SIZEOFHEADERS = 1053;
  IDC_STATIC_SIZEOFIMAGE = 1054;
  IDC_STATIC_RESERVED = 1055;
  IDC_STATIC_SUBSYSVERSION = 1056;
  IDC_STATIC_IMAGEVERSION = 1057;
  IDC_STATIC_SIZEOFSTACK_COMMIT = 1058;
  IDC_STATIC_SIZEOFHEAP_RESERVED = 1059;

  allfiles_filterstring = 'All PE files'#0'*.exe;*.dll;*.ocx;*.bpl;*.cpl;*.dpl;*.com;*.sys;*.scr'#0+
  'EXE files'#0'*.exe'#0+
  'DLL files'#0'*.dll'#0+
  'OCX files'#0'*.ocx'#0+
  'BPL files'#0'*.bpl'#0+
  'CPL files'#0'*.cpl'#0+
  'DPL files'#0'*.dpl'#0+
  'COM files'#0'*.com'#0+
  'SYS files'#0'*.sys'#0+
  'SCR files'#0'*.scr'#0+
  'All files'#0'*.*'#0#0;
  textfiles_filterstring = 'Text files'#0'*.txt'#0 + allfiles_filterstring;

  // text constants
  progname = 'EXE/PE Properties - (c) 2002 by -=Assarbad=-';

var
  NTImgHeaders: IMAGE_NT_HEADERS;
  bool_pefile, bool_dosexe: boolean;
  globfilename: string;
  GlobCorrectChecksum: DWORD = 0;
  ofn: TOpenFilename;
  maindlg: HWND = 0;
  ofn_buffer: array[0..MAX_PATH] of Char;

{$INCLUDE .\Include\FormatString.pas}
{$INCLUDE .\Include\time_t.pas}
{$INCLUDE .\Include\PE_Format.pas}

function DWORD2hex(dw: DWORD): string;
begin
  result := Format('%8.8Xh', [dw]);
end;

function WORD2hex(dw: word): string;
begin
  result := Format('%4.4Xh', [dw]);
end;

function BYTE2hex(dw: byte): string;
begin
  result := Format('%2.2Xh', [dw]);
end;


function XXX2str(dw: DWORD): string;
begin
  result := Format('%d', [dw]);
end;

function Filetime2str(ft: FILETIME): string;
var
  st: SYSTEMTIME;
begin
  if FileTimeToSystemTime(ft, st) then
    result := Format('%2.2d-%2.2d-%2.2d@%2.2d:%2.2d:%2.2d', [st.wDay, st.wMonth, st.wYear, st.wSecond, st.wMinute, st.wHour])
  else
    result := 'invalid date';
end;

function WordVersion2str(vhi, vlo: word): string;
begin
  result := Format('%d.%d (%4.4X.%4.4X)', [vhi, vlo, vhi, vlo]);
end;

function ByteVersion2str(vhi, vlo: byte): string;
begin
  result := Format('%d.%d (%2.2X.%2.2X)', [vhi, vlo, vhi, vlo]);
end;

function Mach2Str(mac: word): string;
begin
  case mac of
    IMAGE_FILE_MACHINE_UNKNOWN: result := 'Supposed to run on any (MACHINE_UNKNOWN)';
    IMAGE_FILE_MACHINE_I386: result := 'Intel 386+ (MACHINE_I386)';
    IMAGE_FILE_MACHINE_R3000: result := 'MIPS little-endian (MACHINE_R3000)';
    IMAGE_FILE_MACHINE_R3000_0x160: result := 'MIPS big-endian (MACHINE_R3000_0x160)';
    IMAGE_FILE_MACHINE_R4000: result := 'MIPS little-endian (MACHINE_R4000)';
    IMAGE_FILE_MACHINE_R10000: result := 'MIPS little-endian (MACHINE_R10000)';
    IMAGE_FILE_MACHINE_WCEMIPSV2: result := 'MIPS little-endian WCE v2 (MACHINE_WCEMIPSV2)';
    IMAGE_FILE_MACHINE_ALPHA: result := 'Alpha_AXP (MACHINE_ALPHA)';
    IMAGE_FILE_MACHINE_SH3: result := 'SH3 little-endian (MACHINE_SH3)';
    IMAGE_FILE_MACHINE_SH3DSP: result := '(MACHINE_SH3DSP)';
    IMAGE_FILE_MACHINE_SH3E: result := 'SH3E little-endian (MACHINE_SH3E)';
    IMAGE_FILE_MACHINE_SH4: result := 'SH4 little-endian (MACHINE_SH4)';
    IMAGE_FILE_MACHINE_SH5: result := 'SH5 (MACHINE_SH5)';
    IMAGE_FILE_MACHINE_ARM: result := 'ARM Little-Endian (MACHINE_ARM)';
    IMAGE_FILE_MACHINE_THUMB: result := '(MACHINE_THUMB)';
    IMAGE_FILE_MACHINE_AM33: result := '(MACHINE_AM33)';
    IMAGE_FILE_MACHINE_POWERPC: result := 'IBM PowerPC Little-Endian (MACHINE_POWERPC)';
    IMAGE_FILE_MACHINE_POWERPCFP: result := '(MACHINE_POWERPCFP)';
    IMAGE_FILE_MACHINE_IA64: result := 'Intel 64 (MACHINE_IA64)';
    IMAGE_FILE_MACHINE_MIPS16: result := 'MIPS (MACHINE_MIPS16)';
    IMAGE_FILE_MACHINE_M68K: result := 'Motorola 68000 series (MACHINE_M68K)'; //Motorola 68000 series.
    IMAGE_FILE_MACHINE_ALPHA64: result := 'ALPHA64 (MACHINE_ALPHA64)';
    IMAGE_FILE_MACHINE_MIPSFPU: result := 'MIPS (MACHINE_MIPSFPU)';
    IMAGE_FILE_MACHINE_MIPSFPU16: result := 'MIPS (MACHINE_MIPSFPU16)';
    IMAGE_FILE_MACHINE_TRICORE: result := 'Infineon (MACHINE_TRICORE)';
    IMAGE_FILE_MACHINE_CEF: result := '(MACHINE_CEF)';
    IMAGE_FILE_MACHINE_EBC: result := 'EFI Byte Code (MACHINE_EBC)';
    IMAGE_FILE_MACHINE_AMD64: result := 'AMD64 (K8) (MACHINE_AMD64)';
    IMAGE_FILE_MACHINE_M32R: result := 'M32R little-endian (MACHINE_M32R)';
    IMAGE_FILE_MACHINE_CEE: result := '(MACHINE_CEE)';
  else
    result := '[Unknown (newer?) machine type]';
  end;
end;

function SubSys2str(subsys: Word): string;
begin
  case subsys of
    IMAGE_SUBSYSTEM_UNKNOWN: result := 'UNKNOWN';
    IMAGE_SUBSYSTEM_NATIVE: result := 'NATIVE';
    IMAGE_SUBSYSTEM_WINDOWS_GUI: result := 'WINDOWS_GUI';
    IMAGE_SUBSYSTEM_WINDOWS_CUI: result := 'WINDOWS_CUI';
    IMAGE_SUBSYSTEM_OS2_CUI: result := 'OS2_CUI';
    IMAGE_SUBSYSTEM_POSIX_CUI: result := 'POSIX_CUI';
    IMAGE_SUBSYSTEM_NATIVE_WINDOWS: result := 'NATIVE_WINDOWS';
    IMAGE_SUBSYSTEM_WINDOWS_CE_GUI: result := 'WINDOWS_CE_GUI';
    IMAGE_SUBSYSTEM_EFI_APPLICATION: result := 'EFI_APPLICATION';
    IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER: result := 'EFI_BOOT_SERVICE_DRIVER';
    IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER: result := 'EFI_RUNTIME_DRIVER';
    IMAGE_SUBSYSTEM_EFI_ROM: result := 'EFI_ROM';
    IMAGE_SUBSYSTEM_XBOX: result := 'XBOX';
  else
    result := '[None of the pre-defined]';
  end;
end;

// has to be included ... uses previous functions
{$INCLUDE .\Include\StatusHint.pas}

function MakeReport_PE: string;
const
  crlf = #13#10;
  _4space = '    ';
  _8space = '        ';
  _alignspace = '                              ';
var
  ft: FILETIME;
begin
  result := '[Start of report]' + crlf;
  result := result + crlf;
  result := result + 'Filename:' + crlf;
  result := result + '---------' + crlf;
  result := result + _4space + globfilename + crlf + crlf;
  result := result + 'Trailing "MZ" ';
  case bool_dosexe of
    false: result := result + 'not ';
  end;
  result := result + 'found.' + crlf + crlf;
  if bool_dosexe then
    case bool_pefile of
      true:
        begin
          result := result + 'Found PE signature (PE\0\0) and IMAGE_FILE_HEADER.' + crlf + crlf;
          result := result + 'IMAGE_FILE_HEADER ->' + crlf;
          result := result + '--------------------' + crlf;
          result := result + _4space + 'Machine                     = ' + dword2hex(NTImgHeaders.FileHeader.Machine) + ' (' + mach2str(NTImgHeaders.FileHeader.Machine) + ')' + crlf;
          result := result + _4space + 'NumberOfSections            = ' + dword2hex(NTImgHeaders.FileHeader.NumberOfSections) + ' = ' + XXX2str(NTImgHeaders.FileHeader.NumberOfSections) + crlf;
          ft := UnixTimeToFileTime(NTImgHeaders.FileHeader.TimeDateStamp);
          result := result + _4space + 'TimeDateStamp               = ' + dword2hex(NTImgHeaders.FileHeader.TimeDateStamp) + ' (' + FileTime2str(ft) + ')' + crlf;
          result := result + _4space + 'PointerToSymbolTable        = ' + dword2hex(NTImgHeaders.FileHeader.PointerToSymbolTable) + ' = ' + XXX2str(NTImgHeaders.FileHeader.PointerToSymbolTable) + crlf;
          result := result + _4space + 'NumberOfSymbols             = ' + dword2hex(NTImgHeaders.FileHeader.NumberOfSymbols) + ' = ' + XXX2str(NTImgHeaders.FileHeader.NumberOfSymbols) + crlf;
          result := result + _4space + 'SizeOfOptionalHeader        = ' + dword2hex(NTImgHeaders.FileHeader.SizeOfOptionalHeader) + ' = ' + XXX2str(NTImgHeaders.FileHeader.SizeOfOptionalHeader) + crlf;
          result := result + _4space + 'Characteristics             = ' + dword2hex(NTImgHeaders.FileHeader.Characteristics) + ' = ' + XXX2str(NTImgHeaders.FileHeader.Characteristics) + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_RELOCS_STRIPPED) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_RELOCS_STRIPPED' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_EXECUTABLE_IMAGE) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_EXECUTABLE_IMAGE' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_LINE_NUMS_STRIPPED) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_LINE_NUMS_STRIPPED' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_LOCAL_SYMS_STRIPPED) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_LOCAL_SYMS_STRIPPED' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_AGGRESSIVE_WS_TRIM) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_AGGRESSIVE_WS_TRIM' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_LARGE_ADDRESS_AWARE) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_LARGE_ADDRESS_AWARE' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_16BIT_MACHINE) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_16BIT_MACHINE' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_BYTES_REVERSED_LO) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_BYTES_REVERSED_LO' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_32BIT_MACHINE) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_32BIT_MACHINE' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_DEBUG_STRIPPED) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_DEBUG_STRIPPED' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_NET_RUN_FROM_SWAP) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_NET_RUN_FROM_SWAP' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_SYSTEM) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_SYSTEM' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_DLL) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_DLL' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_UP_SYSTEM_ONLY) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_UP_SYSTEM_ONLY' + crlf;
          if (NTImgHeaders.FileHeader.Characteristics and IMAGE_FILE_BYTES_REVERSED_HI) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_FILE_BYTES_REVERSED_HI' + crlf;
          result := result + crlf;
          result := result + 'IMAGE_OPTIONAL_HEADER ->' + crlf;
          result := result + '------------------------' + crlf;
          result := result + _4space + 'Magic                       = ' + dword2hex(NTImgHeaders.OptionalHeader.Magic) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Magic) + crlf;
          case NTImgHeaders.OptionalHeader.Magic of
            PE32_norm: result := result + _8space + _alignspace + '-> PE32' + crlf;
            PE32_plus: result := result + _8space + _alignspace + '-> PE32+' + crlf;
          else
            result := result + _8space + _alignspace + '-> Unknown PE type (newer version?)' + crlf;
          end;
          result := result + _4space + 'MajorLinkerVersion          = ' + dword2hex(NTImgHeaders.OptionalHeader.MajorLinkerVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MajorLinkerVersion) + crlf;
          result := result + _4space + 'MinorLinkerVersion          = ' + dword2hex(NTImgHeaders.OptionalHeader.MinorLinkerVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MinorLinkerVersion) + crlf;
          result := result + _8space + _alignspace + '-> ' + ByteVersion2str(NTImgHeaders.OptionalHeader.MajorLinkerVersion, NTImgHeaders.OptionalHeader.MinorLinkerVersion) + crlf;
          result := result + _4space + 'SizeOfCode                  = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfCode) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfCode) + crlf;
          result := result + _4space + 'SizeOfInitializedData       = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfInitializedData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfInitializedData) + crlf;
          result := result + _4space + 'SizeOfUninitializedData     = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfUninitializedData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfUninitializedData) + crlf;
          result := result + _4space + 'AddressOfEntryPoint         = ' + dword2hex(NTImgHeaders.OptionalHeader.AddressOfEntryPoint) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.AddressOfEntryPoint) + crlf;
          result := result + _4space + 'BaseOfCode                  = ' + dword2hex(NTImgHeaders.OptionalHeader.BaseOfCode) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.BaseOfCode) + crlf;
          result := result + _4space + 'BaseOfData                  = ' + dword2hex(NTImgHeaders.OptionalHeader.BaseOfData) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.BaseOfData) + crlf;
          result := result + _4space + 'ImageBase                   = ' + dword2hex(NTImgHeaders.OptionalHeader.ImageBase) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.ImageBase) + crlf;
          result := result + _4space + 'SectionAlignment            = ' + dword2hex(NTImgHeaders.OptionalHeader.SectionAlignment) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SectionAlignment) + crlf;
          result := result + _4space + 'FileAlignment               = ' + dword2hex(NTImgHeaders.OptionalHeader.FileAlignment) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.FileAlignment) + crlf;
          result := result + _4space + 'MajorOperatingSystemVersion = ' + dword2hex(NTImgHeaders.OptionalHeader.MajorOperatingSystemVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MajorOperatingSystemVersion) + crlf;
          result := result + _4space + 'MinorOperatingSystemVersion = ' + dword2hex(NTImgHeaders.OptionalHeader.MinorOperatingSystemVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MinorOperatingSystemVersion) + crlf;
          result := result + _8space + _alignspace + '-> ' + WordVersion2str(NTImgHeaders.OptionalHeader.MajorOperatingSystemVersion, NTImgHeaders.OptionalHeader.MinorOperatingSystemVersion) + crlf;
          result := result + _4space + 'MajorImageVersion           = ' + dword2hex(NTImgHeaders.OptionalHeader.MajorImageVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MajorImageVersion) + crlf;
          result := result + _4space + 'MinorImageVersion           = ' + dword2hex(NTImgHeaders.OptionalHeader.MinorImageVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MinorImageVersion) + crlf;
          result := result + _8space + _alignspace + '-> ' + WordVersion2str(NTImgHeaders.OptionalHeader.MajorImageVersion, NTImgHeaders.OptionalHeader.MinorImageVersion) + crlf;
          result := result + _4space + 'MajorSubsystemVersion       = ' + dword2hex(NTImgHeaders.OptionalHeader.MajorSubsystemVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MajorSubsystemVersion) + crlf;
          result := result + _4space + 'MinorSubsystemVersion       = ' + dword2hex(NTImgHeaders.OptionalHeader.MinorSubsystemVersion) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.MinorSubsystemVersion) + crlf;
          result := result + _8space + _alignspace + '-> ' + WordVersion2str(NTImgHeaders.OptionalHeader.MajorSubsystemVersion, NTImgHeaders.OptionalHeader.MinorSubsystemVersion) + crlf;
          result := result + _4space + 'Reserved1                   = ' + dword2hex(NTImgHeaders.OptionalHeader.Win32VersionValue) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Win32VersionValue) + crlf;
          result := result + _4space + _alignspace + '(sometimes referred to as Win32VersionValue)' + crlf;
          result := result + _4space + 'SizeOfImage                 = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfImage) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfImage) + crlf;
          result := result + _4space + 'SizeOfHeaders               = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeaders) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeaders) + crlf;
          result := result + _4space + 'CheckSum                    = ' + dword2hex(NTImgHeaders.OptionalHeader.CheckSum) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.CheckSum) + crlf;
          result := result + _4space + 'Subsystem                   = ' + dword2hex(NTImgHeaders.OptionalHeader.Subsystem) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.Subsystem) + crlf;
          result := result + _8space + _alignspace + '-> ' + subsys2str(NTImgHeaders.OptionalHeader.Subsystem) + crlf;
          result := result + _4space + 'DllCharacteristics          = ' + dword2hex(NTImgHeaders.OptionalHeader.DllCharacteristics) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.DllCharacteristics) + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_PROCESS_INIT) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_PROCESS_INIT' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_PROCESS_TERM) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_PROCESS_TERM' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_THREAD_INIT) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_THREAD_INIT' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_THREAD_TERM) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_THREAD_TERM' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_NO_BIND) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_NO_BIND' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_WDM_DRIVER) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_WDM_DRIVER' + crlf;
          if (NTImgHeaders.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE) <> 0 then
            result := result + _8space + _alignspace + 'IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE' + crlf;
          result := result + _4space + 'SizeOfStackReserve          = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfStackReserve) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfStackReserve) + crlf;
          result := result + _4space + 'SizeOfStackCommit           = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfStackCommit) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfStackCommit) + crlf;
          result := result + _4space + 'SizeOfHeapReserve           = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeapReserve) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeapReserve) + crlf;
          result := result + _4space + 'SizeOfHeapCommit            = ' + dword2hex(NTImgHeaders.OptionalHeader.SizeOfHeapCommit) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.SizeOfHeapCommit) + crlf;
          result := result + _4space + 'LoaderFlags                 = ' + dword2hex(NTImgHeaders.OptionalHeader.LoaderFlags) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.LoaderFlags) + crlf;
          result := result + _4space + _alignspace + '(These values are not documented!)' + crlf;
          result := result + _4space + 'NumberOfRvaAndSizes         = ' + dword2hex(NTImgHeaders.OptionalHeader.NumberOfRvaAndSizes) + ' = ' + XXX2str(NTImgHeaders.OptionalHeader.NumberOfRvaAndSizes) + crlf;
          result := result + crlf;
          result := result + 'Misc. Information' + crlf;
          result := result + '-----------------' + crlf;
          result := result + _4space + 'Correct PE checksum         = ' + dword2hex(GlobCorrectChecksum) + ' = ' + XXX2str(GlobCorrectChecksum) + crlf;
          result := result + crlf;
          result := result + '[End of report]' + crlf;
        end;
    else
      result := result + 'This appears to be just a DOS EXE file (OS/2 or some other non-PE is also possible).' + crlf;
    end
  else
    result := result + 'This is no EXE or PE file.';
end;

function dlgfunc(hwnd: HWND; umsg: Cardinal; wparam: WPARAM; lparam: LPARAM): BOOL; stdcall;
var
  SizeWritten, hchecksum, gchecksum: DWORD;
  errstr: string;
  pc: pchar;
  hFileWrite: THandle;

  procedure showheader(imghead: IMAGE_NT_HEADERS);
  var
    ft: FILETIME;
  begin
    SetDlgItemText(hwnd, IDC_STATIC_FILENAME, @globfilename[1]);
    case bool_dosexe of
      false: CheckRadioButton(hwnd, IDC_RADIO_PE32, IDC_RADIO_NONEXE, IDC_RADIO_NONEXE);
    else
      case bool_pefile of
        false: CheckRadioButton(hwnd, IDC_RADIO_PE32, IDC_RADIO_NONEXE, IDC_RADIO_NONPE);
      else
        case ImgHead.OptionalHeader.Magic of
          PE32_norm: CheckRadioButton(hwnd, IDC_RADIO_PE32, IDC_RADIO_NONEXE, IDC_RADIO_PE32);
          PE32_plus: CheckRadioButton(hwnd, IDC_RADIO_PE32, IDC_RADIO_NONEXE, IDC_RADIO_PE32_PLUS);
        else
          CheckRadioButton(hwnd, IDC_RADIO_PE32, IDC_RADIO_NONEXE, IDC_RADIO_PE_UNKNOWN);
        end;
      end;
    end;
    SetDlgItemText(hwnd, IDC_EDIT_MACTYPE, @WORD2hex(ImgHead.FileHeader.Machine)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_MACTYPE_CT, @Mach2Str(ImgHead.FileHeader.Machine)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_NUMSEC, @XXX2str(ImgHead.FileHeader.NumberOfSections)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_PTSYMTAB, @DWORD2hex(ImgHead.FileHeader.PointerToSymbolTable)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_NUMSYM, @XXX2str(ImgHead.FileHeader.NumberOfSymbols)[1]);
    ft := UnixTimeToFileTime(ImgHead.FileHeader.TimeDateStamp);
    SetDlgItemText(hwnd, IDC_EDIT_TIMESTAMP, @Filetime2str(ft)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_SIZEOFOH, @XXX2str(ImgHead.FileHeader.SizeOfOptionalHeader)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_CHARACT, @WORD2hex(ImgHead.FileHeader.Characteristics)[1]);

    SendDlgItemMessage(hwnd,IDC_COMBO_CHARACT,CB_RESETCONTENT ,0,0);
    SendDlgItemMessage(hwnd,IDC_COMBO_LOADERFLAGS,CB_RESETCONTENT ,0,0);
    SendDlgItemMessage(hwnd,IDC_COMBO_DLLCHARACT ,CB_RESETCONTENT ,0,0);

    SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(@WORD2hex(ImgHead.FileHeader.Characteristics)[1]));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_RELOCS_STRIPPED) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_RELOCS_STRIPPED')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_EXECUTABLE_IMAGE) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_EXECUTABLE_IMAGE')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_LINE_NUMS_STRIPPED) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_LINE_NUMS_STRIPPED')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_LOCAL_SYMS_STRIPPED) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_LOCAL_SYMS_STRIPPED')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_AGGRESSIVE_WS_TRIM) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_AGGRESSIVE_WS_TRIM')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_LARGE_ADDRESS_AWARE) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_LARGE_ADDRESS_AWARE')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_16BIT_MACHINE) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_16BIT_MACHINE')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_BYTES_REVERSED_LO) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_BYTES_REVERSED_LO')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_32BIT_MACHINE) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_32BIT_MACHINE')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_DEBUG_STRIPPED) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_DEBUG_STRIPPED')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_NET_RUN_FROM_SWAP) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_NET_RUN_FROM_SWAP')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_SYSTEM) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_SYSTEM')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_DLL) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_DLL')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_UP_SYSTEM_ONLY) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_UP_SYSTEM_ONLY')));
    if (ImgHead.FileHeader.Characteristics and IMAGE_FILE_BYTES_REVERSED_HI) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_ADDSTRING, 0, integer(pchar('IMAGE_FILE_BYTES_REVERSED_HI')));
    SendDlgItemMessage(hwnd, IDC_COMBO_CHARACT, CB_SETCURSEL, 0, 0);

    SetDlgItemText(hwnd, IDC_STATIC_MAGICWORD, @WORD2hex(ImgHead.OptionalHeader.Magic)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_LINKERVERSION, @ByteVersion2str(ImgHead.OptionalHeader.MajorLinkerVersion, ImgHead.OptionalHeader.MinorLinkerVersion)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFCODE, @XXX2str(ImgHead.OptionalHeader.SizeOfCode)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFINITEDDATA, @XXX2str(ImgHead.OptionalHeader.SizeOfInitializedData)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFUNINITEDDATA, @XXX2str(ImgHead.OptionalHeader.SizeOfUninitializedData)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_BASEOFCODE, @DWORD2hex(ImgHead.OptionalHeader.BaseOfCode)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_BASEOFDATA, @DWORD2hex(ImgHead.OptionalHeader.BaseOfData)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_IMAGEBASE, @DWORD2hex(ImgHead.OptionalHeader.ImageBase)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SECTALIGN_HEX, @DWORD2hex(ImgHead.OptionalHeader.SectionAlignment)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_FILEALIGN_HEX, @DWORD2hex(ImgHead.OptionalHeader.FileAlignment)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SECTALIGN_DEC, @XXX2str(ImgHead.OptionalHeader.SectionAlignment)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_FILEALIGN_DEC, @XXX2str(ImgHead.OptionalHeader.FileAlignment)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_OSVERSION, @WordVersion2str(ImgHead.OptionalHeader.MajorOperatingSystemVersion, ImgHead.OptionalHeader.MinorOperatingSystemVersion)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_IMAGEVERSION, @WordVersion2str(ImgHead.OptionalHeader.MajorImageVersion, ImgHead.OptionalHeader.MinorImageVersion)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SUBSYSVERSION, @WordVersion2str(ImgHead.OptionalHeader.MajorSubsystemVersion, ImgHead.OptionalHeader.MinorSubsystemVersion)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFIMAGE, @XXX2str(ImgHead.OptionalHeader.SizeOfImage)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_RESERVED, @DWORD2hex(ImgHead.OptionalHeader.Win32VersionValue)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFHEAP_RESERVED, @XXX2str(ImgHead.OptionalHeader.SizeOfHeapReserve)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFHEAP_COMMIT, @XXX2str(ImgHead.OptionalHeader.SizeOfHeapCommit)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFSTACK_RESERVED, @XXX2str(ImgHead.OptionalHeader.SizeOfStackReserve)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFSTACK_COMMIT, @XXX2str(ImgHead.OptionalHeader.SizeOfStackCommit)[1]);

    SetDlgItemText(hwnd, IDC_STATIC_SUBSYSTEM, @DWORD2hex(ImgHead.OptionalHeader.Subsystem)[1]);
    SetDlgItemText(hwnd, IDC_EDIT_SUBSYSTEM, @subsys2str(ImgHead.OptionalHeader.Subsystem)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_CHECKSUM, @DWORD2hex(ImgHead.OptionalHeader.CheckSum)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_SIZEOFHEADERS, @XXX2str(ImgHead.OptionalHeader.SizeOfHeaders)[1]);
    SetDlgItemText(hwnd, IDC_STATIC_ADDRESSOFENTRY, @DWORD2hex(ImgHead.OptionalHeader.AddressOfEntryPoint)[1]);

    SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(@DWORD2hex(ImgHead.OptionalHeader.DllCharacteristics)[1]));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_PROCESS_INIT) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('PROCESS_INIT')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_PROCESS_TERM) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('PROCESS_TERM')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_THREAD_INIT) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('THREAD_INIT')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_LIBRARY_THREAD_TERM) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('THREAD_TERM')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_NO_BIND) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('NO_BIND')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_WDM_DRIVER) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('WDM_DRIVER')));
    if (ImgHead.OptionalHeader.DllCharacteristics and IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE) <> 0 then
      SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_ADDSTRING, 0, integer(pchar('TERMINAL_SERVER_AWARE')));
    SendDlgItemMessage(hwnd, IDC_COMBO_DLLCHARACT, CB_SETCURSEL, 0, 0);

    SendDlgItemMessage(hwnd, IDC_COMBO_LOADERFLAGS, CB_ADDSTRING, 0, integer(@DWORD2hex(ImgHead.OptionalHeader.LoaderFlags)[1]));
    // Loaderflags are not documented
    SendDlgItemMessage(hwnd, IDC_COMBO_LOADERFLAGS, CB_SETCURSEL, 0, 0);

    MapFileAndCheckSum(@globfilename[1], hchecksum, gchecksum);
    if GetLastError = ERROR_SUCCESS then
      begin
        SetDlgItemText(hwnd, IDC_STATIC_CALCCHECKSUM, @DWORD2hex(gchecksum)[1]);
        GlobCorrectChecksum := gchecksum;
      end
    else
      GlobCorrectChecksum := 0;
    EnableWindow(GetDlgItem(hwnd, IDC_BUTTON_SETCHECKSUM), true);
    if gchecksum <> 0 then
      if gchecksum = ImgHead.OptionalHeader.CheckSum then
        EnableWindow(GetDlgItem(hwnd, IDC_BUTTON_SETCHECKSUM), false);

    SetFocus(GetDlgItem(hwnd, IDCANCEL));
  end;

begin
  Result := TRUE;
  case umsg of
    WM_INITDIALOG:
      begin
        maindlg := hwnd;
        InitHints;
        if globfilename <> '' then
          begin
            bool_pefile := _isexe(globfilename, bool_dosexe, NTImgHeaders);
            showheader(NTImgHeaders);
          end;
        // Check if we can load the image helper DLL
        hchecksum := LoadLibrary(@Imagehlplib[1]);
        if hchecksum <> 0 then
          FreeLibrary(hchecksum)
        else
          begin
            // if not, make the respective controls invisible
            ShowWindow(GetDlgItem(hwnd, IDC_BUTTON_SETCHECKSUM), SW_HIDE);
            ShowWindow(GetDlgItem(hwnd, IDC_STATIC_CALCCHECKSUM), SW_HIDE);
            ShowWindow(GetDlgItem(hwnd, IDC_STATIC_CALCCHECKSUM_), SW_HIDE);
          end;
        hchecksum := 0;
      end;
    WM_CTLCOLORLISTBOX,
      WM_CTLCOLOREDIT,
      WM_CTLCOLORSTATIC:
      case GetDlgCtrlID(lParam) of
        IDC_COMBO_LOADERFLAGS,
          IDC_COMBO_DLLCHARACT,
          IDC_COMBO_CHARACT:
          begin
            SetBkColor(wParam, GetSysColor(COLOR_3DFACE));
            SetTextColor(wParam, $00008800);
            result := BOOL(GetSysColorBrush(COLOR_3DFACE));
          end;
        IDC_STATIC_FILENAME:
          begin
            SetBkColor(wParam, GetSysColor(COLOR_3DFACE));
            SetTextColor(wParam, $000000FF);
            result := BOOL(GetSysColorBrush(COLOR_3DFACE));
          end
      else
        result := BOOL(FALSE);
      end;
    WM_CLOSE:
      begin
        DeInitHints;
        PostQuitMessage(0);
        EndDialog(hwnd, 0);
      end;
    WM_COMMAND:
      // Handle all button clicks et cetera
      if HiWord(WParam) = BN_CLICKED then
        case LOWORD(wParam) of
          IDCANCEL:
            begin
              sendmessage(hwnd, WM_CLOSE, 0, 0);
            end;
          IDC_BUTTON_SETCHECKSUM:
            begin
              if not _setPEchecksum(globfilename, hchecksum, gchecksum) then
                begin
                  case hchecksum of
                    CHECKSUM_OPEN_FAILURE: errstr := 'Could not open file.';
                    CHECKSUM_MAP_FAILURE: errstr := 'Could not map file.';
                    CHECKSUM_MAPVIEW_FAILURE: errstr := 'Could not create a view of the mapped file.';
                    ERROR_CALL_NOT_IMPLEMENTED: errstr := 'A function could not be called. Ensure, that ' + ImagehlpLib + ' is in your path, while executing this program.';
                  else
                    errstr := 'Unknown error (File in use?).';
                  end;
                  messagebox(hwnd, @errstr[1], nil, 0);
                end;
            end;
          IDC_BUTTON_SAVEREPORT:
            begin
              errstr := globfilename + '.txt';
              lstrcpyn(@ofn_buffer[0], @errstr[1], sizeof(ofn_buffer));
              ofn.lpstrFile := @ofn_buffer[0];
              errstr := MakeReport_PE;
              ofn.lStructSize := SizeOf(ofn);
              ofn.hWndOwner := hwnd;
              ofn.hInstance := HInstance;
              ofn.lpstrFilter := textfiles_filterstring;
              ofn.nMaxFile := sizeof(ofn_buffer);
              ofn.Flags := OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY;
              if GetSaveFileName(ofn) then
                begin
                  hFileWrite := CreateFile(ofn_buffer, GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_ARCHIVE, 0);
                  pc := @errstr[1];
                  WriteFile(hFileWrite, pc^, lstrlen(pc), SizeWritten, nil);
                  CloseHandle(hFileWrite);
                end;
              errstr := '';
            end;
          IDC_BUTTON_OPENFILE:
            begin
              ofn.lStructSize := SizeOf(ofn);
              ofn.hWndOwner := hwnd;
              ofn.hInstance := HInstance;
              ofn.lpstrFilter := allfiles_filterstring;
              ofn.lpstrFile := @ofn_buffer[0];
              ofn.nMaxFile := sizeof(ofn_buffer);
              ofn.Flags := OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST or OFN_LONGNAMES or OFN_EXPLORER or OFN_HIDEREADONLY;
              if GetOpenFileName(ofn) then
                begin
                  SetString(globfilename, pchar(@ofn_buffer[0]), lstrlen(@ofn_buffer[0]));
                  ZeroMemory(@NTImgHeaders, sizeof(NTImgHeaders));
                  bool_pefile := _isexe(globfilename, bool_dosexe, NTImgHeaders);
                  showheader(NTImgHeaders);
                end;
            end;
          IDC_BUTTON_STATUS:
            messagebox(hwnd, @progname[1], 'Information', 0);
        end;
  else
    result := false;
  end;
end;

begin
  globfilename := paramstr(1);
  DialogBoxParam(hInstance, MAKEINTRESOURCE(IDD_DIALOG1), 0, @dlgfunc, 0);
end.

