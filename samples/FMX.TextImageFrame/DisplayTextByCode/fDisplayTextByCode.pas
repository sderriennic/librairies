/// <summary>
/// ***************************************************************************
///
/// Librairies pour Delphi
///
/// Copyright 1990-2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// This repository contains functions, procedures and classes to use in
/// Delphi projects (console, VCL, FireMonkey and others). It's my "everything reuseable things" toolbox.
///
/// The units to be used in your projects can be found in the "src" folder.
/// Some features are explained on my blog or have been coded live on Twitch.
///
/// Examples of use in the form of VCL or FireMonkey projects are available in
/// the "samples" subfolder.
///
/// ***************************************************************************
///
/// Author(s) :
///      Patrick PREMARTIN
///
/// Site :
///      https://developpeur-pascal.fr/librairies-publiques.html
///
/// Project site :
///      https://github.com/DeveloppeurPascal/librairies
///
/// ***************************************************************************
/// File last update : 28/05/2024 12:19:14
/// Signature : df83612e2d868bb1ececfdeb07bdc342396253da
/// ***************************************************************************
/// </summary>

unit fDisplayTextByCode;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Olf.FMX.TextImageFrame, FMX.ImgList;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    function ConvertUnknownChars(Sender: TOlfFMXTextImageFrame;
      AChar: char): integer;
    function CreateTextImage(AFont: tcustomimagelist; Atext: string)
      : TOlfFMXTextImageFrame;
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses udm_CharacterImages;

function TForm1.ConvertUnknownChars(Sender: TOlfFMXTextImageFrame;
  AChar: char): integer;
begin
  result := -1;
  if charinset(AChar, ['a' .. 'z']) then // _a, _b, _c in source images
    result := Sender.getImageIndexOfChar('_' + AChar);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CreateTextImage(dm_CharacterImages.ImageList, '012abcABC');
  with CreateTextImage(dm_CharacterImages.ImageList, '') do
  begin
    align := talignlayout.Center;
    OnGetImageIndexOfUnknowChar := ConvertUnknownChars;
    LetterSpacing:=-20;
    text := '012 abc ABC';
  end;
end;

function TForm1.CreateTextImage(AFont: tcustomimagelist; Atext: string)
  : TOlfFMXTextImageFrame;
begin
  result := TOlfFMXTextImageFrame.Create(self);
  with result do
  begin
    parent := self;
    align := talignlayout.top;
    height := 100;
    Font := AFont;
    text := Atext;
  end;
end;

end.
