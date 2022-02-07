#установка и загрузка бибблеотек
library(imager);
# Читается изображение из рабочего директория
MyImageCat <-  load.image("catbl.jpg");
r <- MyImageCat[, , 1]
g <- MyImageCat[, , 2]
b <- MyImageCat[, , 3]

# метод анализа главных компонент отдельно для каждого цветового спектра
MyImageCat.r.pca <- prcomp(r, center = FALSE)
MyImageCat.g.pca <- prcomp(g, center = FALSE)
MyImageCat.b.pca <- prcomp(b, center = FALSE)
rgb.pca <- list(MyImageCat.r.pca, MyImageCat.g.pca, MyImageCat.b.pca)

# готовим формат вывода  
par(mfrow=c(2,4), mar=c(1,1,1,1));

inscription <-data.frame(row.names = c(5, 20, 50, 100, 250, 400), val = c('1','2','3','4','5','6'))
# изображения с разным количеством компонент
for (i in c(5, 20, 50, 100, 250, 400)) {
  pca.img <- sapply(rgb.pca, function(j) {
    compressed.img <- j$x[, 1:i] %*% t(j$rotation[, 1:i])
  }, simplify = 'array')
  plot_name = paste( inscription[as.character(i),],") ", "Кол-во компонентов: ", i ,sep ="");
  plot(as.cimg(pca.img), main=plot_name, axes=FALSE);
}
plot(as.cimg(MyImageCat), main = "7) Исходное фото", axes = FALSE);





