### Задание 1
С помощью библиотеки NumPy реализовать простейший классификатор на основе метода K-ближайших соседей для задач:
- бинарной классификации (то есть, только по двум классам)
- многоклассовой классификации (то есть, по нескольким классам)

Так как методу необходим гиперпараметр - количество соседей, его необходимо выбрать на основе кросс-валидации.

### Задание 2
Проделать шаги многоклассовой классификации с помощью библиотеки scikit-learn.



### Реализация
- В файле [download_data.sh](https://github.com/katrinakulpina/portfolio/blob/main/Python/KNN-classifier/download_data.sh) содержится Bash-скрипт, загружающий данные с удаленного сервера в рабочую директорию. В качестве данных используются цифры из датасета Street View House Numbers ([SVHN](http://ufldl.stanford.edu/housenumbers/)).
- В файле [dataset.py](https://github.com/katrinakulpina/portfolio/blob/main/Python/KNN-classifier/dataset.py) определена функция `load_svhn`, которая извлекает из загруженных файлов данные для тренировки и тестирования и возвращает их как numpy arrays. 
- В файле [knn.py](https://github.com/katrinakulpina/portfolio/blob/main/Python/KNN-classifier/KNN.py) реализован класс `KNN` - сам классификатор.
- В файле [metrics.py](https://github.com/katrinakulpina/portfolio/blob/main/Python/KNN-classifier/metrics.py) определены функции, вычисляющие метрики для оценки модели.

Основной код на Python можно найти в Jupyter-ноутбуке [main.ipynb](https://github.com/katrinakulpina/portfolio/blob/main/Python/KNN-classifier/main.ipynb).
