//
//  InfoTableViewCell.swift
//  NamozVaqtlari_API
//
//  Created by Abdulbosid Jalilov on 04/01/23.
//

import UIKit
import SnapKit


class InfoTableViewCell: UITableViewCell {
    
    //MARK: - WeekDate label -
    
    let weekDate: UILabel = {
       let week = UILabel()
        week.font = .boldSystemFont(ofSize: 20)
        
        return week
    }()
    
    //MARK: - Date Label -
    
    let dateLabel: UILabel = {
       let date = UILabel()
        date.font = .boldSystemFont(ofSize: 20)
        return date
    }()
    
    //MARK: - Tong Saxarlik
    
    let tong_saxarlik: UILabel = {
       let tong = UILabel()
        tong.font = .boldSystemFont(ofSize: 20)
        return tong
    }()
    
    //MARK: - Quyosh
    
    let quyosh: UILabel = {
      let quyosh = UILabel()
        quyosh.font = .boldSystemFont(ofSize: 20)
        return quyosh
    }()
    
    //MARK: - Peshin
    
    let peshinLabel: UILabel = {
       let peshin = UILabel()
        peshin.font = .boldSystemFont(ofSize: 20)
        return peshin
    }()
    
    //MARK: - Asr
    
    let asrLabel: UILabel = {
       let asr = UILabel()
        asr.font = .boldSystemFont(ofSize: 20)
        return asr
    }()
    
    //MARK: - Shom
    
    let shomLabel: UILabel = {
        let shom = UILabel()
        shom.font = .boldSystemFont(ofSize: 20)
        return shom
    }()
    
    //MARK: - Xufton
    
    let xuftonLabel: UILabel = {
       let xufton = UILabel()
        xufton.font = .boldSystemFont(ofSize: 20)
        return xufton
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.addSubview(weekDate)
        weekDate.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(weekDate.snp.top)
            make.left.equalTo(weekDate.snp.right).offset(30)
        }
        
        self.addSubview(tong_saxarlik)
        tong_saxarlik.snp.makeConstraints { make in
            make.top.equalTo(weekDate.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }
        
        self.addSubview(quyosh)
        quyosh.snp.makeConstraints { make in
            make.top.equalTo(tong_saxarlik.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }
        
        self.addSubview(peshinLabel)
        peshinLabel.snp.makeConstraints { make in
            make.top.equalTo(quyosh.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }
        
        self.addSubview(asrLabel)
        asrLabel.snp.makeConstraints { make in
            make.top.equalTo(peshinLabel.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }
        
        self.addSubview(shomLabel)
        shomLabel.snp.makeConstraints { make in
            make.top.equalTo(asrLabel.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }
        
        self.addSubview(xuftonLabel)
        xuftonLabel.snp.makeConstraints { make in
            make.top.equalTo(shomLabel.snp.bottom).offset(10)
            make.left.equalTo(weekDate.snp.left)
        }

    }

}
