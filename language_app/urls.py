from django.urls import path
from .views import ListStatus,CourseTakesList,ProfileDetail,CustomRegisterView,DetailTakes,ListTakes,ContentInLevelList,ListUser,DetailUser,ListPreference,DetailPreference,ListCourse,DetailCourse,ListContent,DetailContent, ListQuiz,DetailQuiz,ListCertificate,DetailCertificate,ListGrade,DetailGrade
urlpatterns = [
    path('registration/',CustomRegisterView.as_view()),
    path('<int:pk>/',DetailUser.as_view()),
    path('',ListUser.as_view()),
    path('profile/<int:pk>/',ProfileDetail.as_view()),
    path('preference/',ListPreference.as_view()),
    path('preference/<int:pk>/',DetailPreference.as_view()),
    path('course/<int:pk>/',DetailCourse.as_view()),
    path('course/',ListCourse.as_view()),
    path('course/takes/',CourseTakesList.as_view()),
    path('course/takes/status',ListStatus.as_view()),
    path('course/content/<int:pk>/',DetailContent.as_view()),
    path('course/content/',ListContent.as_view()),
    path('takes/',ListTakes.as_view()),
    path('takes/<int:pk>/',DetailTakes.as_view()),
    path('quiz/<int:pk>/',DetailQuiz.as_view()),
    path('quiz/',ListQuiz.as_view()),
    path('certeficate/<int:pk>',DetailCertificate.as_view()),
    path('certeficate/',ListCertificate.as_view()),
    path('grade/<int:pk>/',DetailGrade.as_view()),
    path('grade/',ListGrade.as_view()),
    path('level/',ContentInLevelList.as_view()),
    
]