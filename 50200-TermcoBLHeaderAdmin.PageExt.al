pageextension 50200 BLHeaderAdmin extends "BL Header"
{
    actions
    {
        addafter(MakeOrder)
        {
            action(ChangeStatusforAdmin)
            {
                ApplicationArea = all;
                Caption = 'ERPS Change Status';
                image = Holiday;
                Promoted = true;
                PromotedCategory = category6;
                Visible = AdminVisible;

                trigger OnAction()
                begin
                    AdminChangeStatus();
                end;
            }
        }
    }
    local procedure AdminChangeStatus()
    var
        Text0001: Label ' ,Draft,Pre Advised,Acknowledged,Posted';
        SelectionText: Text[100];
        selected: Integer;
    begin
        SelectionText:=Text0001;
        selected:=StrMenu(SelectionText);
        case selected of 2: rec."Doc Status":=rec."Doc Status"::Draft;
        3: rec."Doc Status":=rec."Doc Status"::"Pre Advised";
        4: rec."Doc Status":=rec."Doc Status"::Acknowledged;
        5: rec."Doc Status":=rec."Doc Status"::Posted;
        end;
        Message(format(selected));
        if selected <> 0 then rec.Modify();
    end;
    local procedure adminVisibility()
    var
        user: Record user;
        accesscontrol: Record "Access Control";
    begin
        user.SetRange("User Name", UserId);
        user.FindFirst();
        AdminVisible:=accesscontrol.get(user."User Security ID", 'SUPER', '');
    end;
    trigger OnOpenPage()
    begin
        adminVisibility();
    end;
    var AdminVisible: Boolean;
}
