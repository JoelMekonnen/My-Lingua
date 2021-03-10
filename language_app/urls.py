from django.urls import path
from .views import ListUser,DetailUser,ListPreference,DetailPreference,ListCourse,DetailCourse,ListContent,DetailContent, ListQuiz,DetailQuiz,ListCertificate,DetailCertificate,ListGrade,DetailGrade
urlpatterns = [
    path('<int:pk>/',DetailUser.as_view()),
    path('',ListUser.as_view()),
    path('preference/<int:pk>/',DetailPreference.as_view()),
    path('preference/',ListPreference.as_view()),
    path('course/<int:pk>/',DetailCourse.as_view()),
    path('course/',ListCourse.as_view()),
    path('content/<int:pk>/',DetailContent.as_view()),
    path('content/',ListContent.as_view()),
    path('quiz/<int:pk>/',DetailQuiz.as_view()),
    path('quiz/',ListQuiz.as_view()),
    path('certeficate/<int:pk>',DetailCertificate.as_view()),
    path('certeficate/',ListCertificate.as_view()),
    path('grade/<int:pk>/',DetailGrade.as_view()),
    path('grade/',ListGrade.as_view()),
]