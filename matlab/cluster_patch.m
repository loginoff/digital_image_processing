function [out_img] = cluster_img( img, threshold )
width=size(img,1);
height=size(img,2);
visited=zeros(width,height);
clusters=0;
for r=1:width
    for c=1:height
        if visited(r,c)==0
            clusters=clusters+1;
            current_cluster=[];
            stack=[];
            stackptr=0;
            while stackptr > 0
                idx=stack(stackptr);
                stackptr=stackptr-1;
                
                if idx<1 || idx > width*height
                    break;
                end
                if visited(idx)
                    break;
                end
                
                
            end
        end
    end
end
    %xy to idx
    %(x-1)*width+y
    
    %idx to xy
    %x=ceil(idx/width);
    %y=idx-floor(idx/width);
    function walk(x,y)
        if x<1 || x>width || y < 1 || y > height
            return;
        end
        if visited(x,y)
            return;
        end
        
        idx=(x-1)*width+y;
        if size(current_cluster,1)==0
            comp=img(idx);
        else
            comp=img(current_cluster(end));
        end
        
        if abs(comp - img(idx)) < threshold
            current_cluster(end+1)=idx;
            visited(x,y)=clusters;
            walk(x-1,y-1);
            walk(x-1,y);
            walk(x-1,y+1);
            walk(x,y-1);
            walk(x,y+1);
            walk(x+1,y-1);
            walk(x+1,y);
            walk(x+1,y+1);
        end
    end
out_img=visited;
end

