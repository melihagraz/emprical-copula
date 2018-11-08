
rm(list = ls())
getwd()
library(huge)
library(earth)
library(MASS)
library(huge)


########################################################
#
# Start loop i1 to select each matrix out of 1000.
#
########################################################
n.sim=1000
n.sample<-20
d<-50
p<-50
cr<-"stars"
mt<-"glasso"
# data generation part
f<-huge.generator(n.sim*n.sample,d,graph="scale-free")
datar<-f$data

true.prec<-f$theta
adj<-as.matrix(true.prec)
tpre<-adj

## simulation starts
for(i99 in 1:n.sim){	
     
data<-datar[((n.sample*i99-19):(n.sample*i99)),]

# raw data
test.out1= huge(data, method = mt)
	r.lambda<-huge.select(test.out1, criterion=cr)$opt.lambda
	out1<-huge(data, method = mt,lambda=r.lambda)
	r.path<-out1$path
	r.path<-as.matrix(r.path[[1]])
      epre<-r.path  # estimated precision matrix



TP<-0   
FN<-0
FP<-0
TN<-0

for(i8 in 1:p)
{ 
   for(j8 in 1:p)
   { 
     if(tpre[i8,j8]==epre[i8,j8])
       { 
        if(tpre[i8,j8]==1)
         TP=TP+1 
        else
         TN=TN+1
       }
     else
       { 
        if(tpre[i8,j8]==1)
         FN=FN+1 
        else
         FP=FP+1
       }
    }#end of j8.
}#end of i8.



fdr<-round(FP/(FP+TP),3)

fpr<-round(FP/(FP+TN),3)

pre<-round(TP/(TP+FP),3)

rec<-round(TP/(TP+FN),3)

spe<-round(TN/(TN+FP),3)

acc<-round((TP+TN)/(TP+FP+FN+TN),3)

F<-round(2*(pre*rec)/(pre+rec),3)

MCC<-round((TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)),3)



fileName4 <- paste(mt,cr,d, "-dimensional-row.txt", sep ="")
write(c(i99,TP,FN,FP,TN,spe,fdr,fpr,pre,rec,acc,F,MCC),fileName4,ncol=13,append=T,sep = "\t")

# emprical copula part
ab<-matrix(NA,n.sample,d)

for(i21 in 1:d){
ab[,i21]<-rank(data[,i21])/(n.sample+1)
}
ab




	test.out2= huge(ab, method = mt)
	b.lambda<-huge.select(test.out2,criterion="ric")$opt.lambda
	out2<-huge(ab, method = mt,lambda=b.lambda)
	b.path<-out2$path
	b.path<-as.matrix(b.path[[1]])
	epre<-b.path # estimated precision matrix after emprical copula

TP<-0   
FN<-0
FP<-0
TN<-0

for(i8 in 1:p)
{ 
   for(j8 in 1:p)
   { 
     if(tpre[i8,j8]==epre[i8,j8])
       { 
        if(tpre[i8,j8]==1)
         TP=TP+1 
        else
         TN=TN+1
       }
     else
       { 
        if(tpre[i8,j8]==1)
         FN=FN+1 
        else
         FP=FP+1
       }
    }#end of j8.
}#end of i8.



fdr<-round(FP/(FP+TP),3)

fpr<-round(FP/(FP+TN),3)

pre<-round(TP/(TP+FP),3)

rec<-round(TP/(TP+FN),3)

spe<-round(TN/(TN+FP),3)

acc<-round((TP+TN)/(TP+FP+FN+TN),3)

F<-round(2*(pre*rec)/(pre+rec),3)

MCC<-round((TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)),3)

fileName5 <- paste(mt,cr,d, "-dimensional-empricalCopula.txt", sep ="")
write(c(i99,TP,FN,FP,TN,spe,fdr,fpr,pre,rec,acc,F,MCC),fileName5,ncol=13,append=T,sep = "\t")
}
a<-read.table("glassostars50-dimensional-empricalCopula.txt")
a1<-round(apply(a,2,mean),4)
write(a1,"MEAN-glassostars50-dimensional-empricalCopula.txt",ncol=13)

b<-read.table("glassostars50-dimensional-row.txt")
b1<-round(apply(b,2,mean),4)
write(b1,"MEAN-glassostars50-dimensional-row.txt",ncol=13)




