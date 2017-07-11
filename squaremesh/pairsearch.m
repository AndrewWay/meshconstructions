function [ pairqueue ] = pairsearch( p,x,y,qr )
    %Given a point, find the points surrounding it within distance qr
    import java.util.LinkedList;
    pairqueue=LinkedList();
    n=size(x,1);
    for j=1:n
        % fprintf('j: %d\n',j);
        newp=[x(j),y(j)];
        sepdistance=abs(norm(newp-p));
        if (sepdistance <= qr)
            pairqueue.add(j);%add the point index to the pair queue
        end
    end
end

