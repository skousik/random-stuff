function str = mat2LaTeX(x, varargin)
% Written by Shreyas Kousik (skousik@umich.edu)
% Updated: 16 Feb 2016

% Returns a numerical matrix or vector as a string formatted for LaTeX
% Inputs:
%   x         -- (double/sym) nxm matrix or vector
%   numForm   -- (string) format for the output string; default is <= 3
%                significant figures
%   header    -- (double/logical) if True or 1 then include the LaTeX
%                array header, footer, and parentheses; default is True
%   arrForm   -- (string) 'r' or 'c', which tells LaTeX what kind of array
%                alignment to use (default is 'r')
%   cleanMult -- (logical) if True then remove all '*' characters from
%                output string (default is True)
% Outputs:
%   str      -- a string that can be pasted into LaTeX


% Set default values of optional inputs
    numForm = 3 ;
    arrForm = 'r' ;
    header = True ;
    cleanMult = True ;

    if nargin > 1
        for i = 1:2:length(varargin)
            switch varargin{i}
                case 'numForm'
                    numForm = varargin{i+1} ;
                case 'arrForm'
                    arrForm = varargin{i+1} ;
                case 'header'
                    header = varargin{i+1} ;
                case 'cleanMult'
                    cleanMult = varargin{i+1} ;
            end
        end
    end
    
% Check size of matrix
    [r,c] = size(x) ;
    
% Set up header (or lack thereof)
    if header
        str = ['\left[\begin{array}{', repmat(arrForm,1,r), '} '] ;
    else
        str = [] ;
    end

% Construct output string
    if isa(x,'double')
        for i = 1:r
            for j = 1:c
                if j ~= c
                    % if not the last column, append & between values
                    str = [str, num2str(x(i,j), numForm), ' & '] ;
                else
                    if i ~= r
                        % if not the last row, append \\ after each row
                        str = [str, num2str(x(i,j), numForm), ' \\ '] ;
                    else
                        str = [str, num2str(x(i,j), numForm)] ;
                    end
                end
            end
        end
    elseif isa(x,'sym')
        for i = 1:r
            for j = 1:c
                if j ~= c
                    % if not the last column, append & between values
                    str = [str, char(x(i,j)), ' & '] ;
                else
                    if i ~= r
                        % if not the last row, append \\ after each row
                        str = [str, char(x(i,j)), ' \\ '] ;
                    else
                        str = [str, char(x(i,j))] ;
                    end
                end
            end
        end
        % clean up the output string if it has any '*' characters in it
        if cleanMult
            str = regexprep(str,'\*',''); 
        end
    end

% Finish output string with footer
    if header == 1
        str = [str, ' \end{array}\right]'] ;
    end
end