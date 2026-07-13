unit sfxmaker;

{
 This self-extraction archive creation unit was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$IFDEF FPC}
 {$mode objfpc}
{$ENDIF}
{$H+}

interface

uses Classes, SysUtils;

function create_sfx(const module:string;const cfg:string;const source:string):boolean;

implementation

var buffer:Pointer;

procedure fast_data_copy(var source:TFileStream;var target:TFileStream);
var amount:LongInt;
const size=1048576;
begin
 source.Seek(0,soFromBeginning);
 if buffer=nil then GetMem(buffer,size);
 while Source.Position<Source.Size do
 begin
  amount:=source.Read(buffer^,size);
  if amount>0 then target.Write(buffer^,amount);
 end;

end;

function create_sfx(const module:string;const cfg:string;const source:string):boolean;
var target:string;
var success:boolean;
var sfx,configuration,archive,sfx_archive:TFileStream;
begin
 target:=ChangeFileExt(source,'.exe');
 sfx:=nil;
 configuration:=nil;
 archive:=nil;
 sfx_archive:=nil;
 success:=True;
 try
  sfx:=TFileStream.Create(module,fmOpenRead or fmShareDenyWrite);
  configuration:=TFileStream.Create(cfg,fmOpenRead or fmShareDenyWrite);
  archive:=TFileStream.Create(source,fmOpenRead or fmShareDenyWrite);
  sfx_archive:=TFileStream.Create(target,fmCreate or fmShareDenyWrite);
  fast_data_copy(sfx,sfx_archive);
  fast_data_copy(configuration,sfx_archive);
  fast_data_copy(archive,sfx_archive);
 except
  success:=False;
 end;
 if sfx_archive<>nil then sfx_archive.Free();
 if archive<>nil then archive.Free();
 if configuration<>nil then configuration.Free();
 if sfx<>nil then sfx.Free();
 if not success then DeleteFile(target);
 Result:=success;
end;

Initialization
 buffer:=nil;
end.

Finalization
 if buffer<>nil then Freemem(buffer);
end.

end.
