function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise
% actually it means if P1 intersects P2 or P1 is in P2, then 1 otherwise 0
%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag=1;
pairs=[[1,2];[2,3];[1,3]];

counter=0;
for t=1:2
    if flag==1
        P=[P1,P2];
        current_P=P(:,(2*(t)-1):2*t);
        if t==1
            other_side=P2;
        else
            other_side=P1;
        end
    else
        break
    end
    if counter==3  % exception-if P2 in P1 then 0
        break
    end
    for j=1:3
        reference=[1,2,3];
        current_edge_pair=pairs(j,:);
        current_edge_point_1=current_edge_pair(1);
        current_edge_point_2=current_edge_pair(2);
        B=reference(reference~=current_edge_point_1);
        C=B(B~=current_edge_point_2);
        
        current_edge_point_seperate_1=current_P(current_edge_point_1,:);
        current_edge_point_seperate_2=current_P(current_edge_point_2,:);
        slope=(current_edge_point_seperate_1(2)-current_edge_point_seperate_2(2))/(current_edge_point_seperate_2(1)-current_edge_point_seperate_1(1));
        constant2=(-1)*(current_edge_point_seperate_1(1))*slope-current_edge_point_seperate_1(2);
        vector=[slope;1];
        if slope==Inf || slope==-Inf
            vector=[1;0];
            constant2=(-1)*current_edge_point_seperate_1(1);
        end
       
        % check first condition that the other side triangle's 3 points are all on the same side
        p1=other_side(1,:)*vector+constant2;
        p2=other_side(2,:)*vector+constant2;
        p3=other_side(3,:)*vector+constant2;
        if p1*p2>0 && p2*p3>0 && p1*p3>0
            % check condition 2 which is the remaining point of the triangle whose edge is being considered
            % is on the opposite side of the 3 points or not 
            coord4=current_P(C(1),:);
            p4=coord4*vector+constant2;
            if p1*p2*p3*p4<0
                flag=0;
                break;
            else
                if other_side==P2
                    counter=counter+1; % exception-if P2 in P1 then 0
                end
            end
        end
        % exception-if P2 in P1 then 0
        if counter==3
            flag=0;
        end          
    end
% *******************************************************************
end