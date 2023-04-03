//
//  Utils.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com.
//
import Foundation

struct Utils {
    private static let months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
    ];
    
    
    private struct DayAmount {
        let day: String
        let amount: Decimal
    }
      
    private static func dateToDayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private static func monthToMonthYearString(month: String) -> String {
        let parts = month.components(separatedBy: "-")
        
        if parts.count < 2 {
            return ""
        }
        
        let idx = Int(parts[1]) ?? 0
        
        return "\(months[idx - 1]) \(parts[0])"
    }
    
    private static func nextDay(date: Date) -> Date {
        return date.advanced(by: 24 * 60 * 60)
    }
    
    private static func generateDic(arr: [Transaction]) -> [String: Decimal] {
        var dic = [String: Decimal]()
        
        for obj in arr {
            let key = dateToDayString(date: obj.date)
            
            if let oldAmount = dic[key] {
                dic[key] =  obj.amount + oldAmount
            } else {
                dic[key] =  obj.amount
            }
        }
        
        return dic
    }
    
    private static func generateAllDays(startDate: Date, endDate: Date,
                                        dic: [String: Decimal]) -> [DayAmount] {
        var data = [DayAmount]();
        
        var currentDate = startDate;
        while currentDate <= endDate {
            let dayStr = dateToDayString(date: currentDate)
            var amount = data.count > 0 ? data[data.count - 1].amount : 0;
            
            if let oldAmount = dic[dayStr] {
                amount += oldAmount
            }
            
            let obj = DayAmount(day: dayStr, amount: amount)
            data.append(obj)
            
            currentDate = nextDay(date: currentDate)
        }
        
        return data
    }
    
    
    private static func groupByMonth(data: [DayAmount]) -> [String: [DayAmount]] {
        var dataByMonth = [String: [DayAmount]]()
        
        for obj in data {
            let parts = obj.day.components(separatedBy: "-")
            let month = parts[0..<2].joined(separator: "-")
            
            if dataByMonth[month] == nil {
                dataByMonth[month] = [obj]
            } else {
                dataByMonth[month]?.append(obj)
            }
        }
        
        return dataByMonth
    }
    
    private static func calculateAvarage(days: [DayAmount]) -> Decimal {
        let total = days.map({ $0.amount }).reduce(0.0) { (acc, curr) in
            acc + curr
        }
        
        return total / Decimal(days.count)
    }
    
    private static func getId(_ month: String) -> Int {
        let parts = month.components(separatedBy: "-")
         
        return months.firstIndex(of: parts[0]) ?? 0
    }
    
    static func calculateCumulativeBalance(transactions: [Transaction]) -> Decimal {
        return transactions.map({ $0.amount }).reduce(0.0) { (acc, curr) in
            acc + curr
        }
    }
    
    static func calculateMAB(transactions: [Transaction]) -> [MonthlyBalance] {
        if transactions.count <= 0  {
            return []
        }
        
        var result = [MonthlyBalance]()
        
        let dic = generateDic(arr: transactions)
        let data = generateAllDays(startDate: transactions[0].date, endDate: transactions[transactions.count - 1].date, dic: dic)
        let dataByMonth = groupByMonth(data: data)
         
        for (key, val) in dataByMonth {
            let avarage = calculateAvarage(days: val)
            let id = getId(key)
            let out = MonthlyBalance(id: result.count + 1, month: monthToMonthYearString(month: key), amount: avarage)
            result.append(out)
        }
        
        result.sort(by: { $0.id  < $1.id })
         
        return result
    }
    
}

