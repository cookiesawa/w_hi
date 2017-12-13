from django.conf.urls import include, url
from django.contrib import admin
from . import root_views # 루트 인덱스

urlpatterns = [
    url(r'^$', root_views.index, name='index'),
    url(r'^polls/', include('polls.urls')),
    url(r'^admin/', admin.site.urls),
]
