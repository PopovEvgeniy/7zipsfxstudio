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

function get_name_without_extension(const source:string):string;
var amount:LongWord;
begin
 amount:=LastDelimiter('.',source);
 if amount=0 then
 begin
  amount:=Length(source);
 end
 else
 begin
  Dec(amount);
 end;
 get_name_without_extension:=Copy(source,1,amount);
end;

function create_sfx(const module:string;const cfg:string;const source:string):boolean;
var target:string;
var success:boolean;
var sfx,configuration,archive,sfx_archive:TFileStream;
begin
 target:=get_name_without_extension(source)+'.exe';
 sfx:=nil;
 configuration:=nil;
 archive:=nil;
 sfx_archive:=nil;
 success:=True;
 try
  sfx:=TFileStream.Create(module,fmOpenRead);
  configuration:=TFileStream.Create(cfg,fmOpenRead);
  archive:=TFileStream.Create(source,fmOpenRead);
  sfx_archive:=TFileStream.Create(target,fmCreate);
  sfx_archive.CopyFrom(sfx,0);
  sfx_archive.CopyFrom(configuration,0);
  sfx_archive.CopyFrom(archive,0);
 except
  success:=False;
 end;
 if sfx<>nil then sfx.Free();
 if configuration<>nil then configuration.Free();
 if archive<>nil then archive.Free();
 if sfx_archive<>nil then sfx_archive.Free();
 if success=False then
 begin
  if FileExists(target)=True then DeleteFile(target);
 end;
 create_sfx:=success;
end;

end.
