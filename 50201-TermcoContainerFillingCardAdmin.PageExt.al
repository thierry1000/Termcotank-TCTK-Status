pageextension 50201 ContainerFillingAdmin extends "Container Filling Card"
{
    actions
    {
        addafter("Ajustement ventilation")
        {
            action(ChangeStatusforAdmin)
            {
                ApplicationArea = all;
                Caption = 'ERPS Change Status';
                image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
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
        Text0001: Label 'open,ready,exported';
        SelectionText: Text[100];
        selected: Integer;
    begin
        SelectionText := Text0001;
        selected := StrMenu(SelectionText);
        case selected of
            1:
                rec.Statut := rec.Statut::open;
            2:
                rec.Statut := rec.Statut::ready;
            3:
                rec.Statut := rec.Statut::exported

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
        AdminVisible := accesscontrol.get(user."User Security ID", 'SUPER', '');
    end;

    trigger OnOpenPage()
    begin
        adminVisibility();
    end;

    var
        AdminVisible: Boolean;
}
