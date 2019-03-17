function [range,solution] = step1(N,threshold,u_0,R)
%tic;
P = 0;
solution = zeros(N,4); %the valid initial condition of Poincare Map
m = 0 ;
%R = [0 10; -1 1 ; 0 10; 0 10];

x0 = zeros(1,4);%Range matrix of state value [ Range Guess associated with physical meaning and reality ]
%[y,theta,xdot,thetadot];
%[must be positive, rad is from -1 to 1,must be positive, assume positive];


for j = 1:N
    for p = 1:4
       x0(1,p) = R(p,1) + (R(p,2) - R(p,1))*rand(1); 
       %x0(1,p) = x(1,p);
    end
%a1 = R(1,1) + (R(1,2)-R(1,1))*rand(1); % define the range of initial value 
%a2 = R(2,1) + (R(2,2)-R(2,1))*rand(1);
%a3 = R(3,1) + (R(3,2)-R(3,1))*rand(1);
%a4 = R(4,1) + (R(4,2)-R(4,1))*rand(1);
 % N samples of x0
                % b is upper limit 
%x0 = [x(1,1) x(1,2) x(1,3) x(1,4)];
x1 = allmo(x0,u_0);

      if norm((x1-x0),inf) <= threshold && x1(1) > 0 && x1(3) > 0
            m = m + 1;
            solution(m,1:4) = x0; 
        %    R = [0 round(solution(1,1)+1); -1 1 ; 0 round(solution(1,3)+1); round(solution(1,4)-1)   round(solution(1,4)+1)];
         %   threshold = threshold - 1 + 1e-4;
      end
      P = m/N;
      if P ~= 0
          if solution(m,1)-1 > 0 
                    aaa = solution(m,1)-1;
          elseif solution(m,3)-1 > 0
                    bbb = solution(m,3)-1;
          else
                    aaa = 0;
                    bbb = 0;
          end
          if m >= 2 
              if max(abs(solution(m,1:4)- allmo(solution(m,1:4),u_0))) <=  max(abs(solution(m-1,1:4)- allmo(solution(m-1,1:4),u_0)))
                
                R = [aaa solution(m,1)+1; -1 1 ; bbb solution(m,3)+1; solution(m,4)-1   solution(m,4)+1];
              end
             
          elseif  m == 1 
              
              R = [aaa solution(1,1)+1; -1 1 ; bbb solution(1,3)+1;solution(1,4)-1   solution(1,4)+1];
          %round(solution(1,4)-2)
          end

            
      elseif P == 0
          R = [0 randi([0 10]); -1 1 ; 0 randi([0 10]); randi([0 10]) randi([0 10])];
      
      end
      
            disp(j);disp('/');disp(N);
     
end
   P = m/N;  
   a1_min = min(solution(1:m,1));
   a1_max = max(solution(1:m,1));
   a2_min = min(solution(1:m,2));
   a2_max = max(solution(1:m,2));
   a3_min = min(solution(1:m,3));
   a3_max = max(solution(1:m,3));
   a4_min = min(solution(1:m,4));
   a4_max = max(solution(1:m,4));
   range = [a1_min a1_max;a2_min a2_max ; a3_min  a3_max ; a4_min a4_max];
  % range = [min(solution(1:m,1))  max(solution(1:m,1)); min(solution(1:m,2))   ]
   % initial_state = solution(end,1:4);

  % plot(solution(1,:),solution(2,:),'o');
  % ax1 = gca;
  % ax1.XColor = 'r';
  % ax1.YColor = 'r';
  % ax1_pos = ax1.Position;
  % ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
 
  %plot(solution(3,:),solution(4,:),'Parent',ax2,'Color','k')
 
  % for kk = 1:m
  %      hold on 
  %      figure(1)
  %      plot(kk,solution(kk,1),'o','Color','r');
  %     plot(kk,solution(kk,2),'p','Color','m');
  %      plot(kk,solution(kk,3),'+','Color','k');
  %      plot(kk,solution(kk,4),'*','Color','c');
  %      legend('y','theta','xdot','thetadot');
  %      ylabel('data value');
  %      xlabel('sets');
  % end
%toc;

end