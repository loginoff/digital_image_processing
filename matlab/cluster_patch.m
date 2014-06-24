function [out_img,nrclusters] = cluster_img( img, threshold )
width=size(img,1);
height=size(img,2);
visited=zeros(width,height);
clusters=0;
for r=1:width
    for c=1:height
        if visited(r,c)==0
            clusters=clusters+1;
            current_cluster=[];
            color=img(r,c);
            stackx=[r];
            stacky=[c];
            stackptr=1;
            while stackptr > 0
                x=stackx(stackptr);
                y=stacky(stackptr);
                stackptr=stackptr-1;
                
                 if x<1 || x>width || y < 1 || y > height
                    continue;
                 end
                 if visited(x,y)
                    continue;
                 end
        
                 idx=(x-1)*width+y;
                 if size(current_cluster,1)==0
                    comp=img(idx);
                 else
                    comp=img(current_cluster(end));
                 end
        
                 if abs(double(color) - double(img(x,y))) < threshold
                    %current_cluster(end+1)=idx;
                    visited(x,y)=clusters;
                    
                    for i=-1:1
                        for j=-1:1
                            newx=x+i;
                            newy=y+j;
                            if newx==x && newy==y
                                continue
                            end
                            if newx<1 || newx>width || newy < 1 || newy > height
                                continue;
                            end
                            if visited(newx,newy)
                                continue;
                            end
                            stackptr=stackptr+1;
                            stackx(stackptr)=newx;
                            stacky(stackptr)=newy;
                        end
                    end
                 end
                
                
            end
        end
    end
end
out_img=visited;
nrclusters=clusters;
end

