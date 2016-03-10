# 名称           
**memusage** - 查看系统当前的内存使用率。                    
             
# 描述             
该工具在计算系统当前的内存使用率时有两种模式:              
           
- 在计算内存使用率时不包含 **Buffer** 和 **Cache** 所占用的内存(默认情况)                
- 在计算内存使用率时包含 **Buffer** 和 **Cache** 所占用的内存(该模式需要使用 **-r** 选项来指定)                
         
# 选项           
**Options:**                       
          
&nbsp;&nbsp;&nbsp;**-h**           
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Show help            
&nbsp;&nbsp;&nbsp;**-e**          
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Don't include Buffer and Cache when calculate Memory Usage(Default)             
&nbsp;&nbsp;&nbsp;**-r**                                                      
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Include Buffer and Cache when calculate Memory Usage                  
             
# 如何使用?               
## 准备工作 

```bash            
$ chmod u+x memusage           
$ sudo mv -v memusage /usr/bin/
```                 
            
## 查看帮助
            
```bash           
$ memusage -h            
```              
            
## 计算内存使用率时不包含 **Buffer** 和 **Cache**                 
           
```bash
$ memusage -e
```            
或           
           
```bash           
$ memusage 
```
            
## 计算内存时包含 **Buffer** 和 **Cache**            
         
```bash            
$ memusage -r
```
