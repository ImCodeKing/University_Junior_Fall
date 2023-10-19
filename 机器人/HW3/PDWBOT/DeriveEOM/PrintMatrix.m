function [] = PrintMatrix(A,name)
% PrintMatrix  prints the matrices that are derived in DeriveEOM.m so that
%	can be copied into Step.m
%
%   See also: STEP, DeriveEOM


[I,J] = size(A);

for i=1:I
    for j=1:J
        cell{i,j} = char(A(i,j));
        cell{i,j} = strrep(cell{i,j},'L','par.L');
        cell{i,j} = strrep(cell{i,j},'R','par.R');
        cell{i,j} = strrep(cell{i,j},'B','par.B');
        cell{i,j} = strrep(cell{i,j},'C','par.C');
        cell_size(i,j) = length(cell{i,j});
    end
end

max_cell_size = max(cell_size);
blanks = '                                                                                                                ';
fprintf('%s = [...\n',name)
for i=1:I
    for j=1:J
        fprintf('\t%s%s',blanks(1:(max_cell_size(j)-cell_size(i,j))),cell{i,j})
        if j<J, fprintf(',  '), end
    end
    if i<I, fprintf(';\n'), end
end
fprintf('  ];\n\n')