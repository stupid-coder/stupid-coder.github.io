import tensorflow as tf
from tensorflow import keras

import numpy as np
import matplotlib.pyplot as plt

print(tf.__version__)

def load_fashion_mnist():
    fashion_mnist = keras.datasets.fashion_mnist
    (train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()
    return (train_images, train_labels), (test_images, test_labels)

class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat', 
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

def plot_image(image):
    plt.figure()
    plt.imshow(image)
    plt.colorbar()
    plt.grid(False)
    plt.show()

def preprocess(train_images, test_images):
    return train_images / 255.0, test_images / 255.0

def display_25_images(images, labels):
    plt.figure(figsize=(10, 10))
    for i in range(25):
        plt.subplot(5,5,i+1)
        plt.xticks([])
        plt.yticks([])
        plt.grid(False)
        plt.imshow(images[i], cmap=plt.cm.binary)
        plt.xlabel(class_names[labels[i]])

def build_model():
    model = keras.Sequential([
        keras.layers.Flatten(input_shape=(28, 28)),
        keras.layers.Dense(128, activation=keras.activations.relu),
        keras.layers.Dense(10, activation=keras.activations.softmax)
    ])
    return model

def compile_model(model):
    model.compile(optimizer=keras.optimizers.Adam(),
                  loss=keras.losses.sparse_categorical_crossentropy,
                  metrics=['accuracy'])

def train_model(model, train_images, train_labels):
    model.fit(train_images, train_labels, epochs=5)

def evaluate_model(model, test_images, test_labels):
    test_loss, test_acc = model.evaluate(test_images, test_labels)
    return test_loss, test_acc

def make_predication(model, images):
    return model.predict(images)

# 加载训练和测试集
(train_images, train_labels), (test_images, test_labels) = load_fashion_mnist()

# 数据预处理
train_images, test_images = preprocess(train_images, test_images)

# 可视化数据集
display_25_images(train_images, train_labels)

# 构建模型
model = build_model()

# 编译模型
compile_model(model)

# 训练模型
train_model(model, train_images, train_labels)

# 在测试集上评估模型
evaluate_model(model, test_images, test_labels)
