function P = mop(grade,na,nb)  %%matrice de puteri ale regresorilor

nr_elem = na+nb;

powers = unique(nchoosek(repmat(0:grade, 1, nr_elem), nr_elem), 'row');
P = powers(sum(powers, 2) <= grade, :);

end