#загрузка установленных библеотек
#install.packages("readr");
library(readr);
#install.packages("Rtsne");
library(Rtsne);
#install.packages("data.table");
library(data.table);

# подготовка данных для анализа
train_set<- fread(file = "winequality-white.csv");
train_set$quality <- as.factor(train_set$quality);

# генераторация случайных чисел
set.seed(1);

# выборка из 4000 значений
rows <- sample(1:nrow(train_set), 4000);

# случайно выбранные числа записываются в матрицу
train <- train_set[rows,];

# алгоритм t-SNE
tsne <- Rtsne(train, perplexity = 10, verbose = TRUE, check_duplicates = FALSE);

# визуализация полученных данных 
colors = rainbow(length(unique(train$quality)));
names(colors) = unique(train$quality);

# визуализация t-SNE
par(mfrow=c(1,1));
plot(tsne$Y, main = "TSNE", xlab = "Компонента 1", ylab = "Компонента 2", "cex.main" = 2);
text(tsne$Y, labels=train$quality, col = colors[train$quality]);
