//
//  main.swift
//  MyCreditManager
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import Foundation

enum InputError: Error {
    case wrongInput
    case duplicated(name: String)
    case noName(name: String)

    var debugDescription: String {
        switch self {
        case .wrongInput: return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .duplicated(let name): return "\(name)은 이미 있습니다. 추가하지 않습니다."
        case .noName(let name): return "\(name)학생을 찾지 못했습니다."
        }
    }
}

class Info {
    let name: String
    var subject: [String: String]
    
    init(name: String, subject: [String : String]? = nil) {
        self.name = name
        self.subject = subject ?? [:]
    }
}

private var infomations = [Info]()
private var loop: Bool = true

private func getIndex(name: String) -> Int? {
    let index = infomations.firstIndex { $0.name == name }
    return index
}

private func getGrade(name: String, index: Int) {
    var totalScore: Double = 0
    let subjects = infomations[index].subject
    for i in subjects {
        print("\(i.key): \(i.value)")
        switch i.value {
        case "A+":
            totalScore += 4.5
        case "A":
            totalScore += 4.0
        case "B+":
            totalScore += 3.5
        case "B":
            totalScore += 3.0
        case "C+":
            totalScore += 2.5
        case "C":
            totalScore += 2.0
        case "D+":
            totalScore += 1.5
        case "D":
            totalScore += 1.0
        default: // F
            totalScore += 0
        }
    }
    let score = totalScore / Double(subjects.count)
    let strScore = String(format: "%.2f", score)
    print("평점: \(strScore)")
}

while loop {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    if let input = readLine() {
        switch input {
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            if let name = readLine(), !name.isEmpty {
                guard getIndex(name: name) != nil else {
                    let info = Info(name: name)
                    infomations.append(info)
                    print("\(name) 학생을 추가했습니다.")
                    break
                }
                let error = InputError.duplicated(name: name).debugDescription
                print(error)
            } else {
                let error = InputError.wrongInput.debugDescription
                print(error)
            }
            
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            if let name = readLine(), !name.isEmpty {
                guard let index = getIndex(name: name) else {
                    let error = InputError.noName(name: name).debugDescription
                    print(error)
                    break
                }
                infomations.remove(at: index)
                print("\(name) 학생을 삭제하였습니다.")
            } else {
                let error = InputError.wrongInput.debugDescription
                print(error)
            }
            
        case "3":
            print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift A+")
            print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
            if let info = readLine()?.split(separator: " "), !info.isEmpty && info.count == 3 {
                let name = String(info[0])
                let subject = String(info[1])
                let score = String(info[2])
                guard let index = getIndex(name: name) else {
                    let error = InputError.noName(name: name)
                    print(error)
                    break
                }
                infomations[index].subject[subject] = score
                print("\(name) 학생의 \(subject) 과목이 \(score)로 추가(변경)되었습니다.")
            } else {
                let error = InputError.wrongInput.debugDescription
                print(error)
            }

        case "4":
            print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift")
            if let info = readLine()?.split(separator: " "), !info.isEmpty && info.count == 2 {
                let name = String(info[0])
                let subject = String(info[1])
                guard let index = getIndex(name: name) else {
                    let error = InputError.noName(name: name)
                    print(error)
                    break
                }
                infomations[index].subject.removeValue(forKey: subject)
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            } else {
                let error = InputError.wrongInput.debugDescription
                print(error)
            }
        case "5":
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
            if let name = readLine(), !name.isEmpty {
                guard let index = getIndex(name: name) else {
                    let error = InputError.noName(name: name)
                    print(error)
                    break
                }
                getGrade(name: name, index: index)
            } else {
                let error = InputError.wrongInput.debugDescription
                print(error)
            }

        case "x", "X":
            print("프로그램을 종료합니다...")
            loop = false
            
        default:
            let error = InputError.wrongInput.debugDescription
            print(error)
        }
    }
}
