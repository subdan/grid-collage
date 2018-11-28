# Collage iOS

<img align="left" src="Icon.png" height="156" width="156">

Collage — iOS приложение для создания коллажа из Instagram фотографий.

<br/><br/>
<br/><br/>

## Функции и особенности
* Интеграция с Instagram API
* Хранение токена в Keychain Services
* Сортировка фотографий по количеству лайков
* Экспорт созданного коллажа
* Выбор типа коллажа
* Сохранение данных в CoreData для оффлайн работы
* Локализация

## Технологии
Nuke, CoreData, AutoLayout, Localization<br>
Swift 4.2, iOS 11/12, Xcode 10.1

## Сборка
Для сборки проекта необходимо указать `clientID` и `redirect_url` в файле [`Helpers/InstagramURLBuilder.swift`](https://github.com/subdan/grid-collage/blob/3d955852cb256d51b7b3ffb7dd5c54a67c2d7310/GridCollage/Helpers/InstagramURLBuilder.swift#L20). Подробности [здесь](https://github.com/subdan/grid-collage/issues/1).

## Скриншоты
<img src="images/IMG_0383.PNG" width="350"> <img src="images/IMG_0382.PNG" width="350">
