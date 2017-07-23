unit sevenzipsfxstudiocode;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, FileUtil, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure LabeledEdit3Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

  var Form1: TForm1;
  function check_input(input:string):Boolean;
  function convert_file_name(source:string): string;
  function execute_program(executable:string;argument:string):Integer;
  procedure execute_command(var command:string);
  procedure create_sfx(sfx:string;configuration:string;archive:string);
  procedure window_setup();
  procedure set_module();
  procedure set_config();
  procedure set_archive();
  procedure interface_setup();
  procedure common_setup();
  procedure language_setup();
  procedure setup();

implementation

function check_input(input:string):Boolean;
var target:Boolean;
begin
target:=True;
if input='' then
begin
target:=False;
end;
check_input:=target;
end;

function convert_file_name(source:string): string;
var target:string;
begin
target:=source;
if Pos(' ',source)>0 then
begin
target:='"'+source+'"';
end;
convert_file_name:=target;
end;

function execute_program(executable:string;argument:string):Integer;
var code:Integer;
begin
try
code:=ExecuteProcess(UTF8ToWinCP(executable),UTF8ToWinCP(argument),[]);
except
On EOSError do code:=-1;
end;
execute_program:=code;
end;

procedure execute_command(var command:string);
var shell,arguments:string;
begin
shell:=GetEnvironmentVariable('COMSPEC');
arguments:='/c '+command;
execute_program(shell,arguments);
end;

procedure create_sfx(sfx:string;configuration:string;archive:string);
var output,target:string;
begin
target:=ExtractFileNameWithoutExt(archive)+'.exe';
output:='copy /b '+convert_file_name(sfx)+'+'+convert_file_name(configuration)+'+'+convert_file_name(archive)+' '+convert_file_name(target);
execute_command(output);
if FileExists(target)=True then
begin
ShowMessage('A self-extraction archive successfully created');
end
else
begin
ShowMessage('A self-extraction archive creation failed');
end;

end;

procedure window_setup();
begin
 Application.Title:='7-ZIP SFX STUDIO';
 Form1.Caption:='7-ZIP SFX STUDIO 2.1.6';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure set_module();
begin
Form1.OpenDialog1.FileName:='*.sfx';
Form1.OpenDialog1.DefaultExt:='*.sfx';
Form1.OpenDialog1.Filter:='SFX module|*.sfx';
end;

procedure set_config();
begin
Form1.OpenDialog1.FileName:='*.txt';
Form1.OpenDialog1.DefaultExt:='*.txt';
Form1.OpenDialog1.Filter:='Configuration file|*.txt';
end;

procedure set_archive();
begin
Form1.OpenDialog1.FileName:='*.7z';
Form1.OpenDialog1.DefaultExt:='*.7z';
Form1.OpenDialog1.Filter:='7-ZIP archive|*.7z';
end;

procedure interface_setup();
begin
Form1.Button1.ShowHint:=False;
Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
Form1.Button3.ShowHint:=Form1.Button1.ShowHint;
Form1.Button4.ShowHint:=Form1.Button1.ShowHint;
Form1.Button4.Enabled:=False;
Form1.LabeledEdit1.Text:='';
Form1.LabeledEdit2.Text:=Form1.LabeledEdit1.Text;
Form1.LabeledEdit3.Text:=Form1.LabeledEdit1.Text;
Form1.LabeledEdit1.LabelPosition:=lpLeft;
Form1.LabeledEdit2.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
Form1.LabeledEdit3.LabelPosition:=Form1.LabeledEdit1.LabelPosition;
Form1.LabeledEdit1.Enabled:=False;
Form1.LabeledEdit2.Enabled:=Form1.LabeledEdit1.Enabled;
Form1.LabeledEdit3.Enabled:=Form1.LabeledEdit1.Enabled;
end;

procedure common_setup();
begin
window_setup();
set_module();
interface_setup();
end;

procedure language_setup();
begin
Form1.Button1.Caption:='Open';
Form1.Button2.Caption:='Open';
Form1.Button3.Caption:='Open';
Form1.Button4.Caption:='Create self-extracting archive';
Form1.LabeledEdit1.EditLabel.Caption:='Self-extracting module';
Form1.LabeledEdit2.EditLabel.Caption:='Configuration file';
Form1.LabeledEdit3.EditLabel.Caption:='Archive';
Form1.OpenDialog1.Title:='Open existing file';
end;

procedure setup();
begin
common_setup();
language_setup();
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
setup();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
Button4.Enabled:=check_input(LabeledEdit1.Text);
Button4.Enabled:=check_input(LabeledEdit2.Text);
Button4.Enabled:=check_input(LabeledEdit3.Text);
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
Button4.Enabled:=check_input(LabeledEdit1.Text);
Button4.Enabled:=check_input(LabeledEdit2.Text);
Button4.Enabled:=check_input(LabeledEdit3.Text);
end;

procedure TForm1.LabeledEdit3Change(Sender: TObject);
begin
Button4.Enabled:=check_input(LabeledEdit1.Text);
Button4.Enabled:=check_input(LabeledEdit2.Text);
Button4.Enabled:=check_input(LabeledEdit3.Text);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
set_module();
if Form1.OpenDialog1.Execute()=True then
begin
Form1.LabeledEdit1.Text:=Form1.OpenDialog1.FileName;
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
set_config();
if Form1.OpenDialog1.Execute()=True then
begin
Form1.LabeledEdit2.Text:=Form1.OpenDialog1.FileName;
end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
set_archive();
if Form1.OpenDialog1.Execute()=True then
begin
Form1.LabeledEdit3.Text:=Form1.OpenDialog1.FileName;
end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
create_sfx(Form1.LabeledEdit1.Text,Form1.LabeledEdit2.Text,Form1.LabeledEdit3.Text);
end;

{$R *.lfm}

{ TForm1 }

{ TForm1 }

end.
