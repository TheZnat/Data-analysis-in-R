#установка и загрузка бибблеотек
library(readr)
library(data.table)
library(umap)
#install.packages("umap");

#Подготовка данных для анализа
train_set <- fread(file = "winequality-white.csv")
train_set$quality <- as.factor(train_set$quality)

#генерирую случайные чисела
set.seed(1);

#Выборка из 4000 значений
rows <- sample(1:nrow(train_set), 4000);
#Случайно выбранные образцы записываются в матрицу train
train <- train_set[rows,];

#Алгоритм umap
train.umap <- umap(train[,1:10]);

#Визуализация полученных данных в цветном формате
colors = rainbow(length(unique(train$quality)));
names(colors) = unique(train.umap$quality);

#Визуализация umap
par(mfrow=c(1,1));
plot(train.umap$layout, t = 'n', main = "UMAP", xlab = "Компонента 1", ylab = "Компонента 2", "cex.main" = 2);
text(train.umap$layout, labels = train$quality, col = colors[train$quality]);

