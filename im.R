# установка пакета для работы 
# install.packages("imager");
# install.packages("devtools");
# devtools::install_github("dahtah/imager");
library(imager);

# загружаем для работы с ним 
MyImage <- load.image("cat.jpg");
# переделываем в Чб 
NewMyImage <- grayscale(MyImage); 

# разложение svd
NewMyImage.svd <- svd(NewMyImage);

# формат вывода  
par(mfrow = c(2,4), mar = c(1,1,1,1));

# создаю фрейм данных
inscription <- data.frame(row.names = c(5, 20, 50, 100, 250, 400), val = c('1','2','3','4','5','6'))
# формируем изображение с  6 параметрами 
# делаем матан и красиво выводим 
for(k in c(5, 20, 50, 100, 250, 400)){
  Matan = NewMyImage.svd$u[,1:k] %*% diag(NewMyImage.svd$d[1:k]) %*% t(NewMyImage.svd$v[,1:k]);
  plot_name = paste(inscription[as.character(k),],") ", "Кол-во компонентов: ", k ,sep ="");
  plot(as.cimg(Matan), main=plot_name, axes=FALSE)
}
plot(as.cimg(NewMyImage), main = "7) Исходное фото", axes = FALSE);