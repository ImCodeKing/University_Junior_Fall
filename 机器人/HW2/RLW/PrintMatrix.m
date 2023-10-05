function [] = PrintMatrix(A,name)
% PrintMatrix  prints the matrices that are derived in DeriveEOM.m 
% so that %	can be copied into Step.m

[I,J] = size(A);

for i=1:I
    for j=1:J
        cell{i,j} = char(A(i,j));
        cell{i,j} = strrep(cell{i,j},'L','par.L');
        cell{i,j} = strrep(cell{i,j},'M','par.M');
        cell{i,j} = strrep(cell{i,j},'R','par.R');
        cell{i,j} = strrep(cell{i,j},'Phi','par.Phi');
        cell{i,j} = strrep(cell{i,j},'g','par.g');
        cell{i,j} = strrep(cell{i,j},'Gamma','par.Gamma');
        cell_size(i,j) = length(cell{i,j});
    end
end
max_cell_size = max(cell_size);

fprintf('%s = [...\n',name)
for i=1:I
    for j=1:J
        fprintf('%s%s', blanks(max_cell_size(j)-cell_size(i,j)), cell{i,j} )
        if j<J, fprintf(','), end
    end
    if i<I, fprintf(';\n'), end
end
fprintf('];\n\n')