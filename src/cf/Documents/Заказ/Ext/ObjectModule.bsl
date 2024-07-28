﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
    
    Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Контрагенты") Тогда
        
		ВидЦен = ДанныеЗаполнения.ВидЦен;
		Покупатель = ДанныеЗаполнения.Ссылка;
        
    ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Товары") Тогда
        
        НоваяСтрока = Товары.Добавить();
        НоваяСтрока.Товар = ДанныеЗаполнения.Ссылка;
        НоваяСтрока.Количество = 1;
        
    КонецЕсли;
    
#Если Не МобильныйАвтономныйСервер Тогда
	Если ЭтоНовый() Тогда
		Пользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
		Автор = Справочники.Пользователи.НайтиПоКоду(Пользователь);
    КонецЕсли;
#КонецЕсли
    
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
    
    Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;   
	
 	// Если заполнено поле "Покупатель"
	Если ПустаяСтрока(Покупатель) Тогда

		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = НСтр("ru = 'Необходимо указать покупателя'", "ru");
		Сообщение.Поле  = "Покупатель";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();

	КонецЕсли;
   
	Сумма = Товары.Итог("Сумма");
#Если Не МобильныйАвтономныйСервер Тогда
	Если ЭтоНовый() Тогда
		Пользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
		Автор = Справочники.Пользователи.НайтиПоКоду(Пользователь);
	КонецЕсли;
#КонецЕсли
    
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
    
	//Удалим из списка проверяемых реквизитов валюту, если по организации не ведется 
	//валютный учет
	Если НЕ ПолучитьФункциональнуюОпцию("ВалютныйУчет", Новый Структура("Организация", Организация)) Тогда
		ПроверяемыеРеквизиты.Удалить(ПроверяемыеРеквизиты.Найти("Валюта"));
    КонецЕсли;	
    
КонецПроцедуры

