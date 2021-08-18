#include "loader.h"

QJsonDocument Loader::loadJson(QString fileName)
{
    QFile jsonFile(fileName);
    jsonFile.open(QFile::ReadOnly);
    return QJsonDocument().fromJson(jsonFile.readAll());
}



void Loader::playlist_toJobject( const QVector<Data> & m_data)
{

    QJsonObject root;

    QJsonArray jsonArray;

    for(int i = 0; i < m_data.size(); i++) {

        QJsonObject jsonObject;
        jsonObject.insert("name", m_data.at(i).name);
        jsonObject.insert("path", m_data.at(i).path);
        jsonObject.insert("duration", m_data.at(i).duration);
        jsonArray.append(jsonObject);
    }

    root["tracks"] = jsonArray;


    QByteArray ba = QJsonDocument(root).toJson();

       {
           QFile fout("output.json");
           fout.open(QFile::WriteOnly | QFile::Truncate);
           fout.write(ba);
       }






}

void Loader::saveJson(QJsonDocument document, QString fileName)
{
    QFile jsonFile(fileName);
    jsonFile.open(QFile::WriteOnly|QFile::Append);
    jsonFile.write(document.toJson());

}











void Loader::DeserPlaylist(QString track_json, QVector<Data> & m_data) //deserailization of playlist
{
    QJsonObject json_obj = loadJson(track_json).object();
    QJsonArray ptsArray = json_obj.value("tracks").toArray();
    foreach(const QJsonValue & val, ptsArray){
        QString x=val.toObject().value("name").toString();
        QString z=val.toObject().value("path").toString();
        double y=val.toObject().value("duration").toDouble();
        m_data.append(Data(x,z,y));
    }


}


Loader::Loader(QObject *parent) :
    QObject()
{


}
