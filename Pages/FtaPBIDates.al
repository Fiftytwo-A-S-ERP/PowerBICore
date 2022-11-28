page 6042303 PBIDatesFTA
{

    APIGroup = 'B365';
    APIPublisher = 'FiftytwoAS';
    APIVersion = 'v1.0';
    Caption = 'FtaPBIDates';
    DelayedInsert = true;
    EntityName = 'PBIPages';
    EntitySetName = 'PBIDates';
    PageType = API;
    SourceTable = Date;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(PeriodType; "Period Type")
                {
                    ApplicationArea = All;
                    Caption = 'PeriodType';
                }
                field(Date; "Period Start")
                {
                    ApplicationArea = All;
                    Caption = 'PeriodStart';
                }
                field(PeriodName; "Period Name")
                {
                    ApplicationArea = All;
                    Caption = 'PeriodName';
                }
                field(Fiscal; gFiscalYear)
                {
                    ApplicationArea = All;
                    Caption = 'Fiscal Year';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        lAccountPeriod: Record "Accounting Period";
        lFiscalEnd: Record "Accounting Period";
        TempText: Text;
    begin
        lAccountPeriod.SetRange("New Fiscal Year", true);
        lAccountPeriod.SetFilter("Starting Date", '..%1', Rec."Period Start");
        if lAccountPeriod.FindLast() then
            gFiscalYear := Format(Date2DMY(lAccountPeriod."Starting Date", 3));
        lAccountPeriod.SetFilter("Starting Date", '%1..', Rec."Period Start");
        if lAccountPeriod.FindFirst() then begin
            TempText := Format(Date2DMY(CalcDate('<-1D>', lAccountPeriod."Starting Date"), 3));
            if TempText > gFiscalYear then
                gFiscalYear += '-' + TempText;
        end;
    end;

    trigger OnOpenPage()
    var
        lAccountPeriodFirst: Record "Accounting Period";
        lAccountPeriodLast: Record "Accounting Period";
    begin
        lAccountPeriodFirst.FindFirst();
        lAccountPeriodLast.FindLast();

        SetRange("Period Type", "Period Type"::Date);
        SetFilter("Period Start", '%1..%2', lAccountPeriodFirst."Starting Date", CalcDate('<CM>', lAccountPeriodLast."Starting Date"));
        // SetFilter("Period Start", '1900-01-01..2099-12-31');
    end;

    var
        gFiscalYear: Text;
}
