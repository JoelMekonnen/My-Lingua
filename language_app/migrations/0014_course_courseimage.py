# Generated by Django 3.1.7 on 2021-03-12 20:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('language_app', '0013_auto_20210308_1816'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='courseImage',
            field=models.FileField(max_length=255, null=True, upload_to='courseImages/'),
        ),
    ]