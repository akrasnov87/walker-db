START TRANSACTION;

INSERT INTO core.sd_settings(id, c_key, c_value, c_summary, c_type)
VALUES(1, 'system.day_del_after', '365', 'Период хранения данных в action_log', 'INT'),
(2, 'geo_quality', 'LOW', 'Качество координат, можно передать high  тогда будет получение по GPS', 'TEXT'),
(3, 'image_quality', '0.6', 'Качество сжатия изображения', 'DOUBLE'),
(4, 'image_height', '720', 'Качество изображения', 'INT'),
(5, 'main_menu_web_site_link', 'https://sway.office.com/n9MsQfCOtcMuWyUR?ref=Link', 'Ссылка на инструкцию', 'TEXT'),
(6, 'main_menu_qr_enable', false, 'Пункт меню сканирование QR', 'BOOL'),
(7, 'create_point_enable', false, 'Отображение функции добавления точек маршрута', 'BOOL'),
(8, 'result_save_enable', false, 'Активность кнопки сохранить в карточке результата', 'BOOL'),
(9, 'result_menu_attachment_enable', false, 'Активность кнопки вложений', 'BOOL'),
(10, 'geo', false, 'Обязательность сохранения гео-данных', 'BOOL'),
(11, 'image', false, 'Обязательность изображения', 'BOOL'),
(12, 'result_menu_qr', false, 'Отображения пункта меня - Сканирование QR в  результатах', 'BOOL'),
(13, 'sync_zip', true, 'Сжатие данных при передаче', 'BOOL'),
(14, 'alert', '', 'Сообщение пользователям', 'TEXT'),
(15, 'walker_claims', 'walker', 'Роль walker', 'TEXT');

INSERT INTO core.pd_roles(id, c_name)
VALUES(1, 'walker') ON CONFLICT (id) DO NOTHING;;

INSERT INTO core.pd_accesses(id, f_role, c_function)
VALUES (1, 1, 'PN.*'), (2, 1, 'core.*'), (3, 1, 'dbo.*') ON CONFLICT (id) DO NOTHING;;

COMMIT TRANSACTION;