# TYWaterFallLayout
##不规则流水布局 - swift3.0

##配图

![](https://github.com/qqcc1388/TYWaterFallLayout/blob/master/source/QQ20170523-1.png)

##使用方法

```
        //创建layout
        let layout = TYWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //遵守数据源
        layout.dataSource = self

        //实现数据源方法
        extension ViewController : TYWaterFallLayoutDataSource{
            //多少列
             func numberOfcols(_ waterFall: TYWaterFallLayout) -> Int {
               return 3
             }
            //每个cell的高度
             func waterFall(_ waterFall: TYWaterFallLayout, item: Int) -> CGFloat {
                 return CGFloat(arc4random_uniform(150)) + CGFloat(100)
              }
        }
```


