//
//  Receiver.swift
//  XO-game
//
//  Created by Андрей Тихонов on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

// MARK: - Receiver

final class Logger {
    
    func writeMessageToLog(_ message: String) {
        /// Здесь должна быть реализация записи сообщения в лог.
        /// Для простоты примера паттерна не вдаемся в эту реализацию,
        /// а просто печатаем текст в консоль.
        print(message)
    }
}
