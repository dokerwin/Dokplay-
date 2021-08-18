#include"appcore.h"
#include<QDir>
#include<QDebug>
#include<QVector>
#include<QQuickView>
#include<QDateTime>


int AppCore::duration__ = 0;

size_t AppCore::temp = 0;

int AppCore::status = 1;



AppCore::AppCore(QObject* parent) : QObject(parent)
{
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this,SLOT(setDuration1()));
    curr_track =0;

    player = new QMediaPlayer;
    player->setVolume(10);

    emit allTracksToQml(playlist.getModel().get_data().size());

}



void AppCore::play()
{
    if(status == player->PlayingState){

        status = player->PausedState;
        timer->stop();
        player->pause();

    }
    else {

        status = player->PlayingState;
        start_playing();

    }


}

void AppCore::start_playing()
{
    player->play();
    timer->start(1000);
}

void AppCore::test(int dur)
{
    qDebug()<<"test dueration "<<dur;
}


void AppCore::set_curr_track()
{
    player->setMedia(QUrl::fromLocalFile(playlist.getModel().get_data().at(curr_track).path));
    emit sendLabelToQml(playlist.getModel().get_data().at(curr_track).name);
    //qDebug()<<playlist.getModel().get_data().at(curr_track).name;
    duration__ = playlist.getModel().get_data().at(curr_track).duration;
    temp = 0;
    emit setDurationSignal(duration__/1000);
}


void AppCore::pause()
{



}


void AppCore::nextTrack()
{    if(curr_track < playlist.getModel().get_data().size()-1){
        curr_track++;
        emit sendLabelToQml(playlist.getModel().get_data().at(curr_track).name);
        set_curr_track();
        start_playing();


    }
}
void AppCore::prevTrack()
{
    if(curr_track >0){
        curr_track--;
        emit sendLabelToQml(playlist.getModel().get_data().at(curr_track).name);
        set_curr_track();

        start_playing();}

    if(curr_track==playlist.getModel().get_data().size()-1){
        curr_track= playlist.getModel().get_data().size()-1;
        emit sendLabelToQml(playlist.getModel().get_data().at(curr_track).name);
        set_curr_track();

        start_playing();
    }
}

void AppCore::randomTrack()
{

    if(curr_track < playlist.getModel().get_data().size()-1){
        curr_track = (qrand() % ((playlist.getModel().get_data().size() + 1) - 0) + 0);
        emit sendLabelToQml(playlist.getModel().get_data().at(curr_track).name);
        set_curr_track();
        play();
    }



}

Playlist &AppCore::getPlaylist()
{
    return playlist;
}




void AppCore::setDirectory(QString directory)
{

    playlist.fillPlaylist(directory);
    emit allTracksToQml(playlist.getCountTracks());



}

int AppCore::getControlLevel() const
{
    return controlLevel;
}

void AppCore::setControlLevel(int _controlLevel)
{

    controlLevel = _controlLevel;
    player->setVolume(controlLevel);
    emit controlLevelChanged(controlLevel);

}

void AppCore::setDuration(int duration)
{



    // if(duration > duration__/1000){
    //   nextTrack();
    //}

    player->setPosition(duration*1000);

    //timer->start(1000);


//    emit durationChanged(player->position()/1000);






    /*int duration_in_seconds = (player->duration()/1000)%60;
    //  qDebug() << "duration = " << duration_in_seconds;
    duration_in_seconds = duration_in_seconds * duration/100;

    connect(player, &QMediaPlayer::durationChanged, this, [&](qint64 dur) {
        emit durationChanged(duration_in_seconds);
        qDebug()<<"setDuration";
    });
*/


}

void AppCore::setDuration1()
{

    if(player->position()< duration__){
         emit durationChanged(player->position()/1000);
    }
    else nextTrack();




}

void AppCore::play_track(QString track)
{


    for (int i = 0; i < playlist.getModel().get_data().size(); ++i) {
        if (playlist.getModel().get_data().at(i).name == track){
            curr_track = i;
            set_curr_track();
            start_playing();
            break;}

    }


}



void AppCore::stop()
{
    status = player->StoppedState;

    player->stop();
    timer->stop();
}





