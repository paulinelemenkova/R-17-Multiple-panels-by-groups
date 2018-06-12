# ЧАСТЬ-1. готовим датафрейм. 
	# шаг-1.
MDepths <- read.csv("DepthTect.csv", header=TRUE, sep = ",")
MDFl <- na.omit(MDepths) 
row.has.na <- apply(MDFl, 1, function(x){any(is.na(x))}) # проверяем, удалил ли все NA
sum(row.has.na) # суммируем все NA, должно получиться: [1] 0
head(MDFl) # смотрим очищенный датафрейм. теперь с ним работаем. 
	
	# шаг-2. сшиваем группы категорий по классам (здесь: тектоника, глубины, углы)
DFDT = melt(setDT(MDFl), measure = patterns("^profile", "^tectonics", "^tg"), value.name = c("depth", "tectonics", "trench_angle"))
head(DFDT)

	# шаг-3. Multiple panels by groups: y ~ x | group строим мульти-график 
p<- xyplot(depth ~ variable | tectonics, 
		group = tectonics, data = DFDT,
		type = c("p", "smooth"),
		scales = "free",
#		scales=list(cex=.5, col="red"),
		main="Multiple ScatterPlot: Depths Distribution by Tectonic Plates",
		xlab="Profiles, Nr")
p
    
