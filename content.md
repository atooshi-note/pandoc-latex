
\clearpage

# contents コンテンツ

## about run pdf生成

```sh
$ docker run -it --rm --volume "$(pwd):/data" manned2665/pandoclatex311 -d pdf-defaults.yaml -M listings
```

## about 書き方

*斜体だよsyataidayo*  
**太字だよHUTOJIDAYO**  
***太字斜体だよHUTOJIsyataidayo***  

contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents contents.  
本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ本文だよ  


URLだよ  

はみ出す↓  
https://aaaaaaaaaaaaaaaaaaaa-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  
[aaaaaaaaaaaaaaaaaaaa-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa](https://aaaaaaaaaaaaaaaaaaaa-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa)  


はみ出す↓（欧文で単語区切りが無いため）  
aaaaaaaaaaaaaaaaaaaa-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  

はみ出さない↓（欧文で単語区切りがあるため自動改行）  

LaTeX is a document markup
language that is particularly well suited for the publication of
mathematical and scientific articles.  

Pandoc is a free-software document converter, widely used as a writing tool (especially by scholars)[2] and as a basis for publishing workflows.[3] It was created by John MacFarlane, a philosophy professor at the University of California, Berkeley.  

はみださない↓（和文）  
あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ  
さ  
き  

\clearpage

## about fig 図

![すごい図[^comment2]](./images/test.png){#fig:sugoi}

すごい[@fig:sugoi]を貼り付けたよ。  
図はスペースいらない  

[^comment2]: 図のタイトルにも注釈をつけられる



## about table 表

| A    | B    | X    |
| ---- | ---- | ---- |
| 0    | 0    | 0    |
| 0    | 1    | 0    |
| 1    | 0    | 0    |
| 1    | 1    | 1    |

: AND {#tbl:AND_yeah}

This is [@tbl:AND_yeah].  
表はスペースが**必要**  


## about equations 式

$$
a^2+b^2=c^2
$${#eq:ainshutain}

This is [@eq:ainshutain] .  
式はスペースいらない  


$\alpha, \beta, \gamma, \delta, \Delta, \varepsilon, \theta, \lambda, \mu, \nu, \pi, \rho, \sigma, \Sigma, \tau, \phi, \omega$

$$\frac{\partial f}{\partial y} \frac{d f}{d x}$$








## about commemts コメント 注釈

This is comment[^comment1].

[^comment1]:This is comment.

\clearpage

## about code block コードブロック

pythonコードを[@lst:code1]に示す。  

```{ .python #lst:code1 .numberLines startFrom="10" caption="nyancam.py"}
"""
にゃんCAM

更新履歴
2021/09/26 : rev0 new
2021/09/29 : rev1 撮影時のみカメラ起動、日本語化
2021/10/08 : rev2 リトライ処理実装（おもにwifiが無くなったことを想定）
2021/10/09 : rev3 カメラ2台対応（1台用とは別にする 1台用はrev2）,カメラ自動認識(1台でも認識はするがエラーになる。あくまで2台用)
2021/10/11 : rev4 カメラ2台用 リトライ処理削除(リトライはsystemdのRestart=alwaysが行うため)
2021/10/13 : rev6 カメラ2台用（ベース：rev4） 起動時にまず撮影
2021/10/13 : rev7 いじり respをそとに resp間にsleep(resp_time) 送る間隔が早すぎてエラーになってたかも(ネットが低速で画像が送れない)


自動起動
sudo nano /lib/systemd/system/nyancam.service
sudo systemctl start nyancam.service
sudo systemctl stop nyancam.service
sudo systemctl enable nyancam.service
sudo systemctl disable nyancam.service

/etc/systemd/system.conf
#DefaultStartLimitInterval=10s
#DefaultStartLimitBurst=5
systemdは10秒の間に5回まで再起動が行われ、それを超えると再起動をやめてしまう
ので、そうならないように起動時にtime.sleep(initwait)する
initwait = 3
10秒では3秒*3回=9秒より、3回しか再起動できないため、再起動しつづける動きとなる

再起動 1日4回 0,6,12,18時
systemdで実装
saikidou.service
saikidou.timer ← enable


機能
・ラズパイ起動時に自動起動、撮影開始
 ・プログラムが失敗（wifi消失などによる）したときはsystemdにより自動再起動する 再試行中はカメラの青LEDが点灯（接続カメラチェックによる）するためわかる 再試行周期はinitwait+5秒くらい
・短押し : テスト撮影（カメラ設置場所決定のため）
・長押し（５秒以上） : shutdown

エラー時（wifi消失）
wifi消失によりエラーとなるのはAPIで通信する
resp = requests.post(api,headers = headers,data = data)
がある以下3箇所
1.### にゃんCAM 起動 ###
2.ボタン短押し（テスト撮影）
3.定期撮影（30分ごととか）

エラーパターン1 : 最初からwifiがない
1.でエラーになる

エラーパターン2 : 途中でwifiがなくなる
1.はきっと通過している
2.や3.でエラーとなる
wifiが復帰したら、最初からやり直しなのでLINEで### にゃんCAM 起動 ###がまた来る

"""
import cv2,time,requests,os
import RPi.GPIO as GPIO
import datetime
import sys

initwait = 3
time.sleep(initwait)

######## Variables ########
rev = 7 # プログラムレビジョン
token = 'あなたのトークン' # LINE Notifyトークン

init = True # 初回のみフラグ
Snapshot_period = 1800 # 撮影周期 sec 30分=60秒*30=1800秒
Longpush_period = 5 # 長押し時間 sec 5秒
shutter_time = 5 # 露光？時間 sec elecomピンクが性能悪いので5秒
resp_time = 1 # カメラ2台 resp間ウエイト（画像が重い）

# リトライ関連
# デバッグ時は短く設定 エラー行数が出ないのが惜しい
MAXTRY = 0 # トライ回数 20回
Try_period = 1 # トライ周期 sec 1分
Trycnt = 0 # トライカウント

######## 接続カメラチェック ########
true_cam = [] # 配列用意
for camera_num in range(10): # カメラ番号を0～9まで変えて、COM_PORTに認識されているカメラを探す
    cap = cv2.VideoCapture(camera_num)
    ret, frame = cap.read()
    if ret == True: # capture.read()に画像が格納されていたら=画像が取得できたら=カメラが接続されていたら
        true_cam.append(camera_num)
        #print('camera number {} Find!'.format(camera_num))
    else: # ここでワーニング
        #print('camera number {} None'.format(camera_num))
        pass
print('接続されているカメラは {} 台です'.format(len(true_cam)))

for i in range(len(true_cam)): # カメラ番号調べ

    print('カメラ{} : {} 番'.format(i,true_cam[i]))

CamNum0 = true_cam[0] # 接続されたカメラの番号
CamNum1 = true_cam[1]
print('CamNum0 : {}'.format(CamNum0))
print('CamNum1 : {}'.format(CamNum1))
#################################

# Setup working directory
os.chdir('/home/USERNAME/Desktop')

# Setup GPIO
button = 26 # VDD(3.3V) - button - GPIO26
GPIO.setmode(GPIO.BCM)
GPIO.setup(button,GPIO.IN,pull_up_down = GPIO.PUD_DOWN) # pull down
button_old = time.time()
trig = False
val = False
long = False
flag = False

# Setup LINE Notify
api = 'https://notify-api.line.me/api/notify'
headers = {'Authorization': 'Bearer' + ' ' + token}
filename0 = 'cat0.jpeg'
images0 = '/home/USERNAME/Desktop/' + filename0
filename1 = 'cat1.jpeg'
images1 = '/home/USERNAME/Desktop/' + filename1

# Setup OpenCV
windowsize = (1024,768) # 4:3 LINE Notifyの送信可能な最大解像度
ImageNum = 0
old = time.time() # 初回時間


try:
    while(True): # にゃんCAM main loop

        if init == True: # 初回のみ
            message = '\n\n### にゃんCAM 起動 ###\nrev:{}\n\n{}分ごとに撮影しまーす！\n接続カメラ : {} 台'.format(rev,Snapshot_period/60,len(true_cam))
            data = {'message': message}
            resp = requests.post(api,headers = headers,data = data)

            print(message)
            print(datetime.datetime.now())

            # 初回にまず撮影する
            shutter_t0 = time.time()
            cap0 = cv2.VideoCapture(CamNum0)
            cap1 = cv2.VideoCapture(CamNum1)

            while True:
                ret, frame0 = cap0.read() # capture(too slow!!)
                ret, frame1 = cap1.read() # capture(too slow!!)
                shutter_t1 = time.time()

                if(shutter_t1 - shutter_t0) > shutter_time: # shutter time
            
                    frame0 = cv2.resize(frame0, windowsize) # resize the window
                    frame1 = cv2.resize(frame1, windowsize) # resize the window

                    cv2.imwrite(filename0,frame0) # save
                    cv2.imwrite(filename1,frame1) # save

                    cap0.release()
                    cap1.release()
                    break # break while loop

            ratelimit_image = resp.headers.get("X-RateLimit-ImageLimit") # max image upload at 1hour
            ratelimit_image_remaining = resp.headers.get("X-RateLimit-ImageRemaining") # image upload remaining

            # for LINE Notify
            # カメラ0
            message0 = '\nカメラ0\nうp残 : {} / {}'.format(ratelimit_image_remaining,ratelimit_image)
            data0 = {'message': message0}
            files0 = {'imageFile': open(images0,'rb')}
            requests.post(api,headers = headers,data = data0,files = files0)

            time.sleep(resp_time)

            # カメラ1
            message1 = '\nカメラ1'
            data1 = {'message': message1}
            files1 = {'imageFile': open(images1,'rb')}
            requests.post(api,headers = headers,data = data1,files = files1)

            # for debug
            print(message0)
            print(message1)

            init = False # 初回のみより、initのTrueへの復帰は不要

        debug0 = time.time() # for measure time of main loop
        
        # button detect
        button_t0 = time.time() # now

        # snapshot
        t0 = time.time() # now
        
        debug1 = time.time() # for debug

        # button detect
        if button_t0 - button_old > 50/1000: # 50msecごと（以上）にボタンの状態を監視
            
            button_state = GPIO.input(button) # check button state
            
            if button_state == 1: # button pushed
                if trig == False: # first pushed
                    firstpush = time.time() # for debug
                    trig = True
                val = True

            else: # button released
                if val == True and long == False: # short pushed( < 5sec ) : Test shot
                    shortpush = time.time() # for debug
                    shutter_t0 = time.time()
                    cap0 = cv2.VideoCapture(CamNum0)
                    cap1 = cv2.VideoCapture(CamNum1)

                    while True:
                        ret, frame0 = cap0.read() # capture(too slow!!)
                        ret, frame1 = cap1.read() # capture(too slow!!)
                        shutter_t1 = time.time()

                        if(shutter_t1 - shutter_t0) > shutter_time: # shutter time
                    
                            frame0 = cv2.resize(frame0, windowsize) # resize the window
                            frame1 = cv2.resize(frame1, windowsize) # resize the window

                            cv2.imwrite(filename0,frame0) # save
                            cv2.imwrite(filename1,frame1) # save

                            cap0.release()
                            cap1.release()
                            break # break while loop

                    ratelimit_image = resp.headers.get("X-RateLimit-ImageLimit") # max image upload at 1hour
                    ratelimit_image_remaining = resp.headers.get("X-RateLimit-ImageRemaining") # image upload remaining

                    # for LINE Notify
                    # カメラ0
                    # message0 = '\nカメラ0\nテスト撮影\n短押し : {} sec\nうp残 : {} / {}\nエラー時リトライ回数 : {} / {}\nリトライ周期 : {} sec'.format(round((shortpush - firstpush),2),ratelimit_image_remaining,ratelimit_image,Trycnt,MAXTRY,Try_period)
                    message0 = '\nカメラ0\nテスト撮影\n短押し : {} sec\nうp残 : {} / {}'.format(round((shortpush - firstpush),2),ratelimit_image_remaining,ratelimit_image)
                    data0 = {'message': message0}
                    files0 = {'imageFile': open(images0,'rb')}
                    requests.post(api,headers = headers,data = data0,files = files0)

                    time.sleep(resp_time)

                    # カメラ1
                    message1 = '\nカメラ1\nテスト撮影'
                    data1 = {'message': message1}
                    files1 = {'imageFile': open(images1,'rb')}
                    requests.post(api,headers = headers,data = data1,files = files1)

                    # for debug
                    print(message0)
                    print(message1)
                    print('main loop : {} sec'.format(debug1 - debug0))
                    
                val = False
                trig = False
                flag = False
                long = False
            
            if val == True: # button pushed
                longpush = time.time() # for debug
                if (longpush - firstpush) > Longpush_period: # long pushed ( > 5sec ) : shutdown
                    if flag == False: # once count
                        print('\n長押し : {} sec'.format(round((longpush - firstpush),2))) # for debug
                        message0 = '\n\n### にゃんCAM シャットダウン ###\n\nばーい！'
                        data = {'message': message0}
                        requests.post(api,headers = headers,data = data)
                        print(message0) # for debug
                        time.sleep(3) # シャットダウンするまで少し待ち
                        # os.system('sudo reboot')
                        os.system('sudo shutdown -h now')
                        flag = True
                        long = True
                        trig = False

            button_old = button_t0

        # 定期撮影
        if t0 - old > Snapshot_period:

            shutter_t0 = time.time() # initial time
            cap0 = cv2.VideoCapture(CamNum0) # VideoCapture
            cap1 = cv2.VideoCapture(CamNum1) # VideoCapture

            while True:
                ret, frame0 = cap0.read() # capture(too slow!!)
                ret, frame1 = cap1.read() # capture(too slow!!)
                shutter_t1 = time.time()

                if(shutter_t1 - shutter_t0) > shutter_time: # shutter time
    
                    frame0 = cv2.resize(frame0, windowsize) # resize the window
                    frame1 = cv2.resize(frame1, windowsize) # resize the window

                    cv2.imwrite(filename0,frame0) # save
                    cv2.imwrite(filename1,frame1) # save

                    cap0.release()
                    cap1.release()
                    break # break while loop
            ratelimit_image = resp.headers.get("X-RateLimit-ImageLimit") # max image upload at 1hour
            ratelimit_image_remaining = resp.headers.get("X-RateLimit-ImageRemaining") # image upload remaining

            #カメラ0
            files0 = {'imageFile': open(images0,'rb')}
            # message0 = '\nカメラ0\nImage_{}\nうp残 : {} / {}\n撮影周期 : {} 分\nエラー時リトライ回数 : {} / {}\nリトライ周期 : {} sec'.format(ImageNum,ratelimit_image_remaining,ratelimit_image,round((t0-old)/60,2),Trycnt,MAXTRY,Try_period)
            message0 = '\nカメラ0\nImage_{}\nうp残 : {} / {}\n撮影周期 : {} 分'.format(ImageNum,ratelimit_image_remaining,ratelimit_image,round((t0-old)/60,2))
            data0 = {'message': message0}
            requests.post(api,headers = headers,data = data0,files = files0)
            
            time.sleep(resp_time)

            #カメラ1
            files1 = {'imageFile': open(images1,'rb')}
            message1 = '\nカメラ1\nImage_{}'.format(ImageNum)
            data1 = {'message': message1}
            requests.post(api,headers = headers,data = data1,files = files1)
            
            # for debug
            print(message0)
            print(message1)
            print(datetime.datetime.now())
            print('main loop : {} sec'.format(debug1 - debug0)) # メインループ実行時間

            old = t0
            ImageNum = ImageNum + 1
        Trycnt = 0 # プログラムに復帰したらトライカウントをリセット

except KeyboardInterrupt:
    print('\nプログラム終了!!')
    sys.exit()
```

# 参考文献 {-}
`{-}` をつけるとこのセクションには見出しに通し番号がつかなくなる

- 箇条書き
- 箇条書き
    - ネスト
    - ネスト
    - ネスト