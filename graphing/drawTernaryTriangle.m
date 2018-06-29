function drawTernaryTriangle(varargin)
% drawTernaryTriangle Draw guiding simplex and circles for one of the
% ternary texture planes.
%   Options:
%    'edgelabels'
%       How to label the corners of the simplex. Set to
%           'probability'   to show probability vectors at simplex edges.
%           'digit'         to show ternary digit at simplex edges.
%           'none'          to skip labeling simplex edges.
%    'fontscale'
%       Scale factor for label fonts.

% parse optional arguments
parser = inputParser;
parser.CaseSensitive = true;
parser.FunctionName = mfilename;

parser.addParameter('edgelabels', 'probability', @(s) ismember(s, {'probability', 'digit', 'none'}));
parser.addParameter('fontscale', 1, @(x) isscalar(x) && isnumeric(x) && x > 0);

% show defaults if asked
if nargin == 1 && strcmp(varargin{1}, 'defaults')
    parser.parse;
    disp(parser.Results);
    return;
end

% parse
parser.parse(varargin{:});
params = parser.Results;

% prepare to revert to the original hold state
washold = ishold;
hold on;

% half the size of a simplex edge
max_t2 = sqrt(3)/2;
% these will be used to draw the circles
angle_range = linspace(0, 2*pi, 100);

% draw circles for orientation (radius 1 and 1/2)
plot(cos(angle_range), sin(angle_range), ':', 'color', [0.4 0.4 0.4]);
plot(0.5*cos(angle_range), 0.5*sin(angle_range), ':', 'color', [0.4 0.4 0.4]);

% draw the probability triangle
plot([-1/2 1 -1/2 -1/2], [-max_t2 0 max_t2 -max_t2], 'color', [0.5 0.7 1]);

% draw the main axes
plot([0 1.5], [0 0], ':', 'color', [1 0.6 0.6], 'linewidth', 1);
plot([0 -1/2*1.5], [0 1.5*max_t2], ':', 'color', [1 0.6 0.6], 'linewidth', 1);
plot([0 -1/2*1.5], [0 -1.5*max_t2], ':', 'color', [1 0.6 0.6], 'linewidth', 1);

% label the corners
if ~strcmp(params.edgelabels, 'none')
    % decide what kind of labels to use
    switch params.edgelabels
        case 'probability'
            l1 = '[0,1,0]';
            l2 = '[0,0,1]';
            l3 = '[1,0,0]';
        case 'digit'
            l1 = '1';
            l2 = '2';
            l3 = '0';
        otherwise
            error([mfilename ':badlabels'], 'Unknown edgelabels.');
    end
    
    % draw the labels
    h1 = text(1.05, 0, l1, 'fontsize', params.fontscale*12, 'color', [0.7 0.7 0.7]);
    h2 = text(-0.5,  max_t2, l2, 'fontsize', params.fontscale*12, 'color', [0.7 0.7 0.7]);
    h3 = text(-0.5, -max_t2, l3, 'fontsize', params.fontscale*12, 'color', [0.7 0.7 0.7]);
    
    % align the labels appropriately
    set(h1, 'horizontalalignment', 'left', 'verticalalignment', 'top');
    set(h2, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
    set(h3, 'horizontalalignment', 'center', 'verticalalignment', 'top');
end

% restore hold state
if ~washold
    hold off;
end

end