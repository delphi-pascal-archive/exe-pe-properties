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

const
  {
    IMAGE_DOS_SIGNATURE = $5A4D; // MZ
    IMAGE_OS2_SIGNATURE = $454E; // NE
    IMAGE_OS2_SIGNATURE_LE = $454C; // LE
    IMAGE_VXD_SIGNATURE = $454C; // LE
    IMAGE_NT_SIGNATURE = $00004550; // PE00

    IMAGE_SIZEOF_SHORT_NAME = 8;
    IMAGE_SIZEOF_SECTION_HEADER = 40;
    IMAGE_NUMBEROF_DIRECTORY_ENTRIES = 16;
    IMAGE_RESOURCE_NAME_IS_STRING = $80000000;
    IMAGE_RESOURCE_DATA_IS_DIRECTORY = $80000000;
    IMAGE_OFFSET_STRIP_HIGH = $7FFFFFFF;
  }
  IMAGE_FILE_MACHINE_UNKNOWN = 0;
  IMAGE_FILE_MACHINE_I386 = $014C; // Intel 386.
  IMAGE_FILE_MACHINE_R3000 = $0162; // MIPS little-endian, 0x160 big-endian
  IMAGE_FILE_MACHINE_R3000_0x160 = $0160; // MIPS little-endian, 0x160 big-endian
  IMAGE_FILE_MACHINE_R4000 = $0166; // MIPS little-endian
  IMAGE_FILE_MACHINE_R10000 = $0168; // MIPS little-endian
  IMAGE_FILE_MACHINE_WCEMIPSV2 = $0169; // MIPS little-endian WCE v2
  IMAGE_FILE_MACHINE_ALPHA = $0184; // Alpha_AXP
  IMAGE_FILE_MACHINE_SH3 = $01A2; // SH3 little-endian
  IMAGE_FILE_MACHINE_SH3DSP = $01A3;
  IMAGE_FILE_MACHINE_SH3E = $01A4; // SH3E little-endian
  IMAGE_FILE_MACHINE_SH4 = $01A6; // SH4 little-endian
  IMAGE_FILE_MACHINE_SH5 = $01A8; // SH5
  IMAGE_FILE_MACHINE_ARM = $01C0; // ARM Little-Endian
  IMAGE_FILE_MACHINE_THUMB = $01C2;
  IMAGE_FILE_MACHINE_AM33 = $01D3;
  IMAGE_FILE_MACHINE_POWERPC = $01F0; // IBM PowerPC Little-Endian
  IMAGE_FILE_MACHINE_POWERPCFP = $01F1;
  IMAGE_FILE_MACHINE_IA64 = $0200; // Intel 64
  IMAGE_FILE_MACHINE_MIPS16 = $0266; // MIPS
  IMAGE_FILE_MACHINE_M68K = $268; //Motorola 68000 series.
  IMAGE_FILE_MACHINE_ALPHA64 = $0284; // ALPHA64
  IMAGE_FILE_MACHINE_MIPSFPU = $0366; // MIPS
  IMAGE_FILE_MACHINE_MIPSFPU16 = $0466; // MIPS
  IMAGE_FILE_MACHINE_AXP64 = IMAGE_FILE_MACHINE_ALPHA64;
  IMAGE_FILE_MACHINE_TRICORE = $0520; // Infineon
  IMAGE_FILE_MACHINE_CEF = $0CEF;
  IMAGE_FILE_MACHINE_EBC = $0EBC; // EFI Byte Code
  IMAGE_FILE_MACHINE_AMD64 = $8664; // AMD64 (K8)
  IMAGE_FILE_MACHINE_M32R = $9041; // M32R little-endian
  IMAGE_FILE_MACHINE_CEE = $C0EE;


  IMAGE_FILE_RELOCS_STRIPPED = $0001; //Image only, Windows CE, Windows NT and above. Indicates that the file does not contain base relocations and must therefore be loaded at its preferred base address. If the base address is not available, the loader reports an error. Operating systems running on top of MS-DOS (Win32s™) are generally not able to use the preferred base address and so cannot run these images. However, beginning with version 4.0, Windows will use an application's preferred base address. The default behavior of the linker is to strip base relocations from EXEs.
  IMAGE_FILE_EXECUTABLE_IMAGE = $0002; //Image only. Indicates that the image file is valid and can be run. If this flag is not set, it generally indicates a linker error.
  IMAGE_FILE_LINE_NUMS_STRIPPED = $0004; //COFF line numbers have been removed.
  IMAGE_FILE_LOCAL_SYMS_STRIPPED = $0008; //COFF symbol table entries for local symbols have been removed.
  IMAGE_FILE_AGGRESSIVE_WS_TRIM = $0010; //Aggressively trim working set.
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020; //App can handle > 2gb addresses.
  IMAGE_FILE_16BIT_MACHINE = $0040; //Use of this flag is reserved for future use.
  IMAGE_FILE_BYTES_REVERSED_LO = $0080; //Little endian: LSB precedes MSB in memory.
  IMAGE_FILE_32BIT_MACHINE = $0100; //Machine based on 32-bit-word architecture.
  IMAGE_FILE_DEBUG_STRIPPED = $0200; //Debugging information removed from image file.
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP = $0400; //If image is on removable media, copy and run from swap file.
  IMAGE_FILE_NET_RUN_FROM_SWAP = $0800; // If Image is on Net, copy and run from the swap file.
  IMAGE_FILE_SYSTEM = $1000; //The image file is a system file, not a user program.
  IMAGE_FILE_DLL = $2000; //The image file is a dynamic-link library (DLL). Such files are considered executable files for almost all purposes, although they cannot be directly run.
  IMAGE_FILE_UP_SYSTEM_ONLY = $4000; //File should be run only on a UP machine.
  IMAGE_FILE_BYTES_REVERSED_HI = $8000; //Big endian: MSB precedes LSB in memory.

  // Subsystem Values
  IMAGE_SUBSYSTEM_UNKNOWN = 0; // Unknown subsystem.
  IMAGE_SUBSYSTEM_NATIVE = 1; // Image doesn't require a subsystem.
  IMAGE_SUBSYSTEM_WINDOWS_GUI = 2; // Image runs in the Windows GUI subsystem.
  IMAGE_SUBSYSTEM_WINDOWS_CUI = 3; // Image runs in the Windows character subsystem.
  IMAGE_SUBSYSTEM_OS2_CUI = 5; // image runs in the OS/2 character subsystem.
  IMAGE_SUBSYSTEM_POSIX_CUI = 7; // image runs in the Posix character subsystem.
  IMAGE_SUBSYSTEM_NATIVE_WINDOWS = 8; // image is a native Win9x driver.
  IMAGE_SUBSYSTEM_WINDOWS_CE_GUI = 9; // Image runs in the Windows CE subsystem.
  IMAGE_SUBSYSTEM_EFI_APPLICATION = 10; //
  IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER = 11; //
  IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER = 12; //
  IMAGE_SUBSYSTEM_EFI_ROM = 13;
  IMAGE_SUBSYSTEM_XBOX = 14;

  // DllCharacteristics Entries
  IMAGE_LIBRARY_PROCESS_INIT = $0001; // Reserved.
  IMAGE_LIBRARY_PROCESS_TERM = $0002; // Reserved.
  IMAGE_LIBRARY_THREAD_INIT = $0004; // Reserved.
  IMAGE_LIBRARY_THREAD_TERM = $0008; // Reserved.
  IMAGE_DLLCHARACTERISTICS_NO_BIND = $0800; // Do not bind this image.
  IMAGE_DLLCHARACTERISTICS_WDM_DRIVER = $2000; // Driver uses WDM model
  IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;

  //signatures
  PE32_norm = $10B;
  PE32_plus = $20B;
type
  {
    IMAGE_DOS_HEADER = packed record // DOS .EXE header
      e_magic: WORD; // Magic number
      e_cblp: WORD; // Bytes on last page of file
      e_cp: WORD; // Pages in file
      e_crlc: WORD; // Relocations
      e_cparhdr: WORD; // Size of header in paragraphs
      e_minalloc: WORD; // Minimum extra paragraphs needed
      e_maxalloc: WORD; // Maximum extra paragraphs needed
      e_ss: WORD; // Initial (relative) SS value
      e_sp: WORD; // Initial SP value
      e_csum: WORD; // Checksum
      e_ip: WORD; // Initial IP value
      e_cs: WORD; // Initial (relative) CS value
      e_lfarlc: WORD; // File address of relocation table
      e_ovno: WORD; // Overlay number
      e_res: packed array[0..3] of WORD; // Reserved words
      e_oemid: WORD; // OEM identifier (for e_oeminfo)
      e_oeminfo: WORD; // OEM information; e_oemid specific
      e_res2: packed array[0..9] of WORD; // Reserved words
      (*e*)_lfanew: Longint; // File address of new exe header
    end;

    PIMAGE_FILE_HEADER = ^IMAGE_FILE_HEADER;
    IMAGE_FILE_HEADER = packed record
      Machine: WORD;
      NumberOfSections: WORD;
      TimeDateStamp: DWORD;
      PointerToSymbolTable: DWORD;
      NumberOfSymbols: DWORD;
      SizeOfOptionalHeader: WORD;
      Characteristics: WORD;
    end;

    PIMAGE_DATA_DIRECTORY = ^IMAGE_DATA_DIRECTORY;
    IMAGE_DATA_DIRECTORY = packed record
      VirtualAddress: DWORD;
      Size: DWORD;
    end;

    PIMAGE_OPTIONAL_HEADER = ^IMAGE_OPTIONAL_HEADER;
    IMAGE_OPTIONAL_HEADER = packed record
      // Standard fields.
      Magic: WORD;
      MajorLinkerVersion: Byte;
      MinorLinkerVersion: Byte;
      SizeOfCode: DWORD;
      SizeOfInitializedData: DWORD;
      SizeOfUninitializedData: DWORD;
      AddressOfEntryPoint: DWORD;
      BaseOfCode: DWORD;
      BaseOfData: DWORD;
      // NT additional fields.
      ImageBase: DWORD;
      SectionAlignment: DWORD;
      FileAlignment: DWORD;
      MajorOperatingSystemVersion: WORD;
      MinorOperatingSystemVersion: WORD;
      MajorImageVersion: WORD;
      MinorImageVersion: WORD;
      MajorSubsystemVersion: WORD;
      MinorSubsystemVersion: WORD;
      Reserved1: DWORD;
      SizeOfImage: DWORD;
      SizeOfHeaders: DWORD;
      CheckSum: DWORD;
      Subsystem: WORD;
      DllCharacteristics: WORD;
      SizeOfStackReserve: DWORD;
      SizeOfStackCommit: DWORD;
      SizeOfHeapReserve: DWORD;
      SizeOfHeapCommit: DWORD;
      LoaderFlags: DWORD;
      NumberOfRvaAndSizes: DWORD;
      DataDirectory: packed array[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1] of IMAGE_DATA_DIRECTORY;
    end;

    IMAGE_NT_HEADERS = packed record
      Signature: DWORD;
      FileHeader: IMAGE_FILE_HEADER;
      OptionalHeader: IMAGE_OPTIONAL_HEADER;
    end;
  }
  PIMAGE_DOS_HEADER = ^IMAGE_DOS_HEADER;
  PIMAGE_NT_HEADERS = ^IMAGE_NT_HEADERS;

function _isEXE(fname: string; var DOS_EXE: boolean; var imghead: IMAGE_NT_HEADERS): boolean;
{
Function-Version 2.02

Returns:     TRUE (if file is of PE-type)
Parameters:
             fname   - file name of file to check
             DOS_EXE - boolean or nil, to verify if file is only a DOS_EXE
             imghead - structure or nil, is filled with the file's headers

Delphi allows to hand over var-parameters of XType as PXType(nil)^, where
type PXType=^XType;
This is good if one does not want to hand over params, but the function also has
to be aware of this possibility. THIS ONE IS!
}
var
  hfile, hmap: THandle;
  saveview, pEXE: pchar; // PChar is an ordinal type
begin
  result := false;
  if @DOS_EXE <> nil then
    DOS_EXE := false;
  if fname <> '' then
    begin
      hfile := createfile(@fname[1], GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
      if hfile <> INVALID_HANDLE_VALUE then
        try
          hmap := CreateFileMapping(hFile, nil, PAGE_READONLY, 0, 0, nil);
          if hmap <> 0 then
            try
              saveview := MapViewOfFile(hMap, FILE_MAP_READ, 0, 0, 0);
              pEXE := saveview;
              if not IsBadReadPtr(pEXE, sizeof(WORD)) then
                begin
                  result := PWORD(pEXE)^ = IMAGE_DOS_SIGNATURE;
                  if @DOS_EXE <> nil then
                    DOS_EXE := result;
                  if result then
                    begin
                      pEXE := pEXE + PIMAGE_DOS_HEADER(pEXE)^._lfanew;
                      if not IsBadReadPtr(pEXE, sizeof(DWORD)) then
                        begin
                          result := PIMAGE_NT_HEADERS(pEXE)^.Signature = IMAGE_NT_SIGNATURE;
                          if result then
                            if @imghead <> nil then
                              CopyMemory(@imghead, pEXE, sizeof(imghead));
                        end;
                    end;
                end;
            finally
              UnmapViewOfFile(saveview);
              CloseHandle(hmap);
            end;
        finally
          CloseHandle(hfile);
        end;
    end;
end;

const
  {image helper}
  CHECKSUM_SUCCESS = 0;
  CHECKSUM_OPEN_FAILURE = 1;
  CHECKSUM_MAP_FAILURE = 2;
  CHECKSUM_MAPVIEW_FAILURE = 3;
  ImagehlpLib = 'IMAGEHLP.DLL';
  name_CheckSumMappedFile = 'CheckSumMappedFile';
  name_MapFileAndCheckSum = 'MapFileAndCheckSumA';

type
  TCheckSumMappedFile = function(BaseAddress: Pointer; FileLength: DWORD; HeaderSum: PDWORD; CheckSum: PDWORD): PImageNtHeaders; stdcall;
  TMapFileAndCheckSum = function(Filename: PChar; var HeaderSum, CheckSum: DWORD): DWORD; stdcall;
var
  CheckSumMappedFile: TCheckSumMappedFile = nil;
  _MapFileAndCheckSum: TMapFileAndCheckSum = nil;

function _setPEchecksum(fname: string; var error: DWORD; var checksum: DWORD): boolean;
var
  lib, hfile, hmap: THandle;
  headersum, nFileSize: DWORD;
  saveview, pEXE: pchar; // PChar is an ordinal type
begin
  result := false;
  lib := GetModuleHandle(@Imagehlplib[1]);
  if lib = 0 then
    lib := LoadLibrary(@Imagehlplib[1]);
  if lib <> 0 then
    begin
      @CheckSumMappedFile := GetProcAddress(lib, @name_CheckSumMappedFile[1]);
    end;
  if not Assigned(CheckSumMappedFile) then
    begin
      error := ERROR_CALL_NOT_IMPLEMENTED;
      exit;
    end;
  if fname <> '' then
    begin
      hfile := createfile(@fname[1], GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
      if hfile <> INVALID_HANDLE_VALUE then
        try
          nFileSize := GetFileSize(hFile, nil);
          hmap := CreateFileMapping(hFile, nil, PAGE_READWRITE, 0, 0, nil);
          if hmap <> 0 then
            try
              saveview := MapViewOfFile(hMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
              if not Assigned(saveview) then
                begin
                  error := CHECKSUM_MAPVIEW_FAILURE;
                  exit;
                end;
              pEXE := saveview;
              if not IsBadReadPtr(pEXE, sizeof(WORD)) then
                if PWORD(pEXE)^ = IMAGE_DOS_SIGNATURE then
                  begin
                    pEXE := pEXE + PIMAGE_DOS_HEADER(pEXE)^._lfanew;
                    if not IsBadReadPtr(pEXE, sizeof(DWORD)) then
                      if PIMAGE_NT_HEADERS(pEXE)^.Signature = IMAGE_NT_SIGNATURE then
                        begin
                          // It's a PE files
                          pEXE := Pointer(CheckSumMappedFile(saveview, nFileSize, @headersum, @Checksum));
                          if Assigned(pEXE) then
                            begin
                              PIMAGE_NT_HEADERS(pEXE)^.OptionalHeader.CheckSum := Checksum;
                              pEXE := Pointer(CheckSumMappedFile(saveview, nFileSize, @headersum, @Checksum));
                              if Assigned(pEXE) then
                                result := true;
                            end;
                        end;
                  end;
            finally
              UnmapViewOfFile(saveview);
              CloseHandle(hmap);
            end
          else
            error := CHECKSUM_MAP_FAILURE;
        finally
          CloseHandle(hfile);
        end
      else
        error := CHECKSUM_OPEN_FAILURE;
    end
  else
    error := CHECKSUM_OPEN_FAILURE;
  FreeLibrary(lib);
end;

function MapFileAndCheckSum(Filename: PChar; var HeaderSum, CheckSum: DWORD): DWORD; stdcall;
var
  lib: THandle;
begin
  result := $FFFF;
  lib := GetModuleHandle(@Imagehlplib[1]);
  if lib = 0 then
    lib := LoadLibrary(@Imagehlplib[1]);
  if lib <> 0 then
    begin
      @_MapFileAndCheckSum := GetProcAddress(lib, @name_MapFileAndCheckSum[1]);
    end;
  if Assigned(_MapFileAndCheckSum) then
    result := _MapFileAndCheckSum(Filename, Headersum, Checksum)
  else
    SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
  FreeLibrary(lib);
end;

