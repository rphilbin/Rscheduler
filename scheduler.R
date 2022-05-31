setwd("/media/xela/E6368EE9368EBA57/Users/pvf")
setwd("C:/Users/S00019201.CCC/Documents/R")

presenters = read.csv("presenters")
#table(presenters$grades)
n.loc = length(unique(presenters$location))
n.loc == dim(presenters)[1]
# PLx=parking lot, Dx=Davis lawn, Fx=Flag
# Bx=BergNorth, Px=Pit, Lx=Library
# Sx=SullivanEast, Cx=Central=between S and L
classes = read.csv("classes")
n.class=dim(classes)[1]

tims = seq(9,15,by=.5)
# slots = outer(tims,
#               unique(presenters$location),
#               FUN={"paste"})
# n.tim=dim(slots)[1] #
n.tim = length(tims)
n.presenters = n.loc=dim(slots)[2]
require(stringr)

# rows=timeSlots, cols=presenter/locations
# content of schedule is index of class
# assume more classes than available slots, so
# doubling up will be required
#
schedArr = array(runif(13*34*5),dim=c(n.tim,n.loc,5))
#
# number of classes in each time/loc slot
schedIdx = matrix(as.integer(0),n.tim,n.loc)

set.seed(1)
bads=numeric()
for(i in 1:n.tim) {
  pres.avail = (presenters$ti <= tims[i]) &
    (tims[i] <= presenters$tf)
  class.avail = which(
    (classes$ti <= tims[i]) &
      (tims[i] <= classes$tf)  )
  nClassNeed = length(class.avail)
  n=0
  jj = which(pres.avail)
  prob = with(presenters[jj,], gmax-gmin)
  prob = prob/sum(prob)
  n.need = length(jj)
  repeat {
    schedArr[i,,] = NA
    schedIdx[i,] = 0
    sc = sample(jj,prob=prob) # == num presenters
    if(nClassNeed>length(jj)) {
      sc = c(sc, sample(jj, nClassNeed-length(jj)))
    }
    for(j in 1:nClassNeed) {
      k = schedIdx[i,sc[j]] = (schedIdx[i,sc[j]] +1)
      schedArr[i,sc[j],k] = class.avail[j]
    }
    bad=0
    for(j in 1:n.loc) {
      cat('\nj=',j)
      pgmin = presenters$gmin[j] # grade min
      pgmax = presenters$gmax[j] # grade max
      kk = schedIdx[i,j]
      if(kk>0) {
        for( k in 1:kk ) {
          # at least one class assigned
          classIdx = schedArr[i,j,k]
          if( !is.na(classIdx) ) {
            cgmin = classes$gmin[classIdx]
            cgmax = classes$gmax[classIdx]
            if( !((cgmin>=pgmin)&(cgmax<=pgmax)) ) {
              bad=bad+1
              cat('\t',i,j,classIdx)
            } # end if grades OK
          } # end if class sched for this time/loc
        } # end for k
      } # end enclosing if(kk>0)
    } # end for j - each location loop
    bad
    if(bad==0) break # no need to keep trying
    n=n+1
    bads = c(bads, bad)
  } # end repeat
  cat('\tn=',n,'; out of repeat',i,'\n')
  # Now put unassigned classes in with other
  # classes in appropriate spots (grade level & max#)
} # for i ~ time slots

printSched = function(n.i = NULL) {
  output ='Schedule:\n'
  if( is.null(n.i) ) n.i=1:n.tim
  for(i in n.i) {
    output=paste(output,'Time slot:',tims[i],'\n')
    for(j in 1:n.loc) {
      # j = presenter id
      # schedule[i,j] # class id
      output=paste(output,'\t',
                   classes$size[schedule[i,j]],
                   'from',
                   classes$school[schedule[i,j]],
                   '\tat\t',
                   presenters$location[j],
                   'limit',
                   presenters$max[j],
                   '\n')
    }
  }
  return (output)
}
write(printSched(1),file="out.txt")


printSchedGradesOnly = function(n.i = -1) {
  output ='Schedule:\n'
  if(n.i== -1) n.i=1:ntim
  for(i in n.i) {
    output=paste(output,'Time slot:',tims[i],'\n')
    for(j in 1:n.loc) {
      # j = presenter id
      # schedule[i,j] # class id
      output=paste(output,'\t cg=(',
                   classes$gmin[schedule[i,j]],
                   ',',classes$gmax[schedule[i,j]],
                   ')\tpg=(',
                   presenters$gmin[j], ',',
                   presenters$gmax[j],
                   ')\n')
    }
  }
  return (output)
}
write(printSchedGradesOnly(1),file="out.txt")
