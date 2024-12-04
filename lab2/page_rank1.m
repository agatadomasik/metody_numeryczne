[numer_indeksu, Edges, I, B, A, b, r] = page_rank()
plot_PageRank(r)


function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 193577;
N = 8;
d = 0.85;
Edges = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8;
         4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 4, 6, 4, 7, 6, 8, 1];

I = speye(N);
B = sparse( Edges(2,:),Edges(1,:),1,N,N);
L = sum(B);
A = spdiags(1./L(:),0,N,N);
b = (1-d)/N * ones(N, 1);
M = I - d * B * A;
r = M \ b;

end

function plot_PageRank(r)
    bar(r);
    xlabel('Page Index');
    ylabel('Page Rank');
    title('Page Ranks');
end

