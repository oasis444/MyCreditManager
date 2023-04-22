//
//  main.swift
//  MyCreditManager
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

struct Student {
    let name: String
}

struct Info {
    let student: Student
    let subject: String?
    let score: String?
}

private var students = [Student]()
private var infomations = [Info]()
private var loop: Bool = true


private func checkStudent(name: String) -> Bool {
    let check = students.contains { $0.name == name }
    return check
}


while loop {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    if let input = readLine() {
        switch input {
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            if let name = readLine(), !name.isEmpty {
                if !checkStudent(name: name) {
                    print("\(name) 학생을 추가했습니다.")
                    let student: Student = Student(name: name)
                    students.append(student)
                } else {
                    print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                }
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            if let name = readLine(), !name.isEmpty {
                if checkStudent(name: name) {
                    print("\(name) 학생을 삭제하였습니다.")
                } else {
                    print("\(name) 학생을 찾지 못했습니다.")
                }
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            
        case "3":
            print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift A+")
            print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
            if let info = readLine()?.split(separator: " "), !info.isEmpty && info.count == 3 {
                let name = String(info[0])
                // 학생이 없으면 추가하지 않기
                let subject = String(info[1])
                let score = String(info[2])
                let infomation = Info(student: Student(name: name), subject: subject, score: score)
                
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            
            
            
            
            
            

        case "4":
            print("4 입력")

        case "5":
            print("5 입력")

        case "x", "X":
            print("프로그램을 종료합니다...")
            loop = false

        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}


