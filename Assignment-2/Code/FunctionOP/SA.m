function [ m_iterations, m_obj ] = SA( T_init, alpha, iterations)

% iterations = 100;
z = 0;
m_iterations = 0;
m_obj = 0;

while (z < iterations)
    % Simulated Annealing (by X-S Yang, Cambridge University)
    % disp('Simulating ... it will take a minute or so!');

    % Rosenbrock's function with f*=0 at (1,1)
    % fstr='(1-x)^2+100*(y-x^2)^2';

    % Egg crate fn
    fstr='x^2 + y^2 + 25*(sin(x)^2 + sin(y)^2)';

    % Convert into an inline function
    f=vectorize(inline(fstr));

    % Show the topography of the objective function
    range=[-5 5 -5 5];
    xgrid=range(1):0.1:range(2); ygrid=range(3):0.1:range(4);
    [x,y]=meshgrid(xgrid,ygrid);
    surfc(x,y,f(x,y)); 

    % Initializing parameters and settings
    % T_init =1000.0; % Initial temperature
    T_min = 1e-10; % Final stopping temperature
    F_min = -1e+100; % Min value of the function
    max_rej=2500; % Maximum number of rejections
    max_run=500; % Maximum number of runs
    max_accept = 15; % Maximum number of accept
    k = 1; % Boltzmann constant
    % alpha=0.95; % Cooling factor
    Enorm=1e-8; % Energy norm (eg, Enorm=le-8)
    guess=[2 2]; % Initial guess

    % Initializing the counters i,j etc
    i= 0; 
    j = 0; % keeps track of # of sequential rejections due to worsening solns
    accept = 0; 
    totaleval = 0;

    % Initializing various values
    T = T_init;
    E_init = f(guess(1),guess(2));
    E_old = E_init; E_new=E_old;
    best=guess; % initially guessed values

    t = 0;

    % Starting the simulated annealling
    while ((T > T_min) & (j <= max_rej) & E_new>F_min)
        i = i+1;

        % Check if max numbers of run/accept are met
        if (i >= max_run) | (accept >= max_accept)
            % Cooling according to a cooling schedule
    %         T = alpha*T;
            t = t+1;
%             T = cooling_schedule1(T_init, alpha, t);
            T = cooling_schedule2(T_init, alpha, t);
            totaleval = totaleval + i;

            % reset the counters
            i = 1; accept = 1;
        end

        % Function evaluations at new locations
        ns=guess+rand(1,2)*randn;
        E_new = f(ns(1),ns(2));
        % Decide to accept the new solution
        DeltaE=E_new-E_old;

        % Accept if improved
        if (-DeltaE > Enorm)
            best = ns; 
            E_old = E_new;
            accept=accept+1; 
            j = 0;
        end

        % Accept with a small probability if not improved
        if (DeltaE<=Enorm & exp(-DeltaE/(k*T))>rand );
            best = ns; 
            E_old = E_new;
            accept=accept+1;
        else
            j=j+1;
        end

        % Update the estimated optimal solution
        f_opt=E_old;
    end

    % Display the final results
    % disp(strcat('Obj function :',fstr));
    % disp(strcat('Evaluations :', num2str(totaleval)));
    % disp(strcat('Best solution:', num2str(best)));
    % disp(strcat('Best objective:', num2str(f_opt)));
    
    m_obj = m_obj + f_opt;
    m_iterations = m_iterations + totaleval;
    z = z + 1;
end

m_iterations = m_iterations/iterations;
m_obj = m_obj/iterations;

% disp(strcat('Evaluations:', num2str(m_iterations)));
% disp(strcat('Best objective:', num2str(m_obj)));

end