function [out_img,nrclusters] = cluster_patch( img, threshold )
width=size(img,1);
height=size(img,2);
visited=zeros(width,height);
clusters=0;
current_clusterx=zeros(1000);
current_clustery=zeros(1000);
for r=1:width
    for c=1:height
        if visited(r,c)==0
            clusters=clusters+1;
            clusterptr=0;
            color=img(r,c);
            meancolor=double(0.0);
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
        
                 if abs(double(color) - double(img(x,y))) < threshold
                     clusterptr=clusterptr+1;
                     current_clusterx(clusterptr)=x;
                     current_clustery(clusterptr)=y;
                     meancolor=double(meancolor)+double(img(x,y));
                    
                    visited(x,y)=clusters;
%                     img(x,y)=color;
                    
                    for i=-1:1
                        for j=-1:1
                            newx=x+i;
                            newy=y+j;
                            if newx==x && newy==y
                                continue;
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
            meancolor=double(meancolor)/double(clusterptr);
            for i=1:clusterptr
                img(current_clusterx(i),current_clustery(i))=uint8(meancolor);
            end
        end
    end
end
out_img=img;
nrclusters=clusters;
end

