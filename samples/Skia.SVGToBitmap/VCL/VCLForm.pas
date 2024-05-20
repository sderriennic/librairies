unit VCLForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Olf.Skia.SVGToBitmap,
  USVGSampleImages;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer1.tag := -1;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.tag := Timer1.tag + 1;
  if (Timer1.tag >= length(SVGSampleImages)) then
    Timer1.tag := 0;

  Image1.picture.Bitmap.Assign(SVGToBitmap(trunc(Image1.Width),
    trunc(Image1.Height), SVGSampleImages[Timer1.tag]));
end;

end.